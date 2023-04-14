#' @title plt_parallel_coordinates
#'
#' @description Parallel coordinates plot
#'
#' @param data A data.table object with the columns containing the parameters to
#'   be plotted with the parallel coordinates plot.
#' @param cols A character vector with column names to subset `data` (default:
#'   `NULL`).
#' @param color_variable A character. The name of the column to be used to
#'   colorize the lines of the plot (default: `NULL`).
#' @param color_args A list with parameters for the color gradient (see
#'   details).
#' @param line_jitter A list with the elements `w` and `h` to define a line
#'   jitter (default: `list(w = 0.04, h = 0.04)`), which are passed further on
#'   to define the position of `ggplot2::geom_line()`.
#' @param text_label_size A numeric value to define the size of the text
#'   annotations (default: `3.5`).
#'
#' @details The color gradient of the plotted lines can be defined with a list
#'   provided to the argument `color_args`. Its default values are
#'   `alpha = 0.6`, `begin = .1`, `end = .9`, `option = "inferno"`, and
#'   `direction = 1` and are passed furhter on to
#'   `ggplot2::scale_color_viridis_c()`.
#'   The implementation to display categorical variables is still experimental.
#'
#' @return Returns a parallel coordinates plot as `ggplot2` object.
#'
#' @seealso [ggplot2::scale_color_viridis_c()]

#' @examples
#' if (require("ggplot2")) {
#'   data("iris")
#'   plt_parallel_coordinates(
#'     data = data.table::as.data.table(iris[, -5]),
#'     cols = colnames(iris)[c(-1, -5)],
#'     color_variable = "Sepal.Length"
#'   )
#' }
#' @export
#
plt_parallel_coordinates <- function(
    data,
    cols = NULL,
    color_variable = NULL,
    color_args = list(alpha = 0.6, begin = .1, end = .9,
                      option = "inferno", direction = 1),
    line_jitter = list(w = 0.04, h = 0.04),
    text_label_size = 3.5
) {
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop(
      paste0(
        "Package \"ggplot2\" must be installed to use ",
        "\"plt_parallel_coordinates\"."
      ),
      call. = FALSE
    )
  }
  # https://stackoverflow.com/a/55699352
  helper <- plt_coordinate_utils()
  LabelParams <- helper$LabelParams # nolint
  geom_label_params <- helper$geom_label_params

  # default color parameters
  color_arg_list <- list(
    alpha = 0.6,
    begin = .1,
    end = .9,
    option = "inferno",
    direction = 1
  )
  # default line jitter
  line_jitter_list <- list(
    w = 0.04,
    h = 0.04
  )
  stopifnot(
    "`line_jitter` must be a list" = is.list(line_jitter),
    "Allowed names of `line_jitter` are 'w' and 'h'" =
      intersect(names(line_jitter),
              names(line_jitter_list)) == names(line_jitter),
    "`color_args` must be a list" = is.list(color_args),
    "Allowed names of `color_args` are 'alpha', 'begin', \
    'end', 'option', and 'direction'" =
      intersect(names(color_args), names(color_arg_list)) == names(color_args),
    "Names of `cols` must exist in `colnames(data)`" = ifelse(
      is.null(cols), TRUE, intersect(cols, colnames(data)) == cols
    ),
    "`color_variable` must exist in `colnames(data)` \
    and only one variable may be provided" = ifelse(
      is.null(color_variable), TRUE,
      intersect(color_variable, colnames(data)) == color_variable &&
        length(color_variable) == 1L
    ),
    "`data` must be a `data.table` object" = data.table::is.data.table(data),
    "`text_label_size` must be a numeric of length() == 1" =
      is.numeric(text_label_size) && length(text_label_size) == 1L
  )

  # updated default_list
  color_arg_list <- list.update(
    main_list = color_arg_list,
    new_list = color_args
  )

  # prepare dataframe
  if (is.null(cols)) {
    cols <- colnames(data)
  }
  data_copy <- data.table::copy(data)
  if (!is.null(color_variable)) {
    data_copy <- data_copy[order(get(color_variable), decreasing = TRUE)]
  }

  # round numeric variables
  num_vars <- colnames(data_copy)[
    data_copy[, vapply(.SD, is.numeric, logical(1L))]
  ]
  num_vars <- setdiff(num_vars, color_variable)
  data_copy[
    ,
    (num_vars) := lapply(
      X = .SD,
      FUN = function(x) {
        sts_normalize(x) %>%
          round(digits = 3)
      }),
    .SDcols = num_vars
  ]

  # character / factor to integer
  data_copy <- cat2integer(data_copy)

  data_copy$id <- rownames(data)
  data_copy <- data.table::melt.data.table(
    data = data_copy,
    id.vars = c("id", color_variable),
    measure.vars = cols
  )
  #%data_copy[, ("x") := as.integer(get("variable"))]

  colpos <- which(colnames(data) %in% cols)

  data_copy %>%
    ggplot2::ggplot(
      ggplot2::aes(
        x = get("variable"),
        y = get("value"),
        color = get(color_variable)
      )
    ) +
    ggplot2::geom_line(
      ggplot2::aes(group = get("id")),
      position = ggplot2::position_jitter(
        w = line_jitter_list[["w"]],
        h = line_jitter_list[["h"]]
      )
    ) +
    ggplot2::scale_color_viridis_c(
      name = color_variable,
      option = color_arg_list$option,
      alpha = color_arg_list$alpha,
      begin = color_arg_list$begin,
      end = color_arg_list$end,
      direction = color_arg_list$direction
    ) +
    ggplot2::xlab("Hyperparameter") +
    ggplot2::ylab("Parameter value") +
    geom_label_params(
      data = data,
      col_pos_vec = colpos,
      vjust = -0.5,
      size = text_label_size
    ) +
    ggplot2::theme(
      axis.text.y = ggplot2::element_blank()
    )
}

plt_coordinate_utils <- function() {

  LabelParams <- ggplot2::ggproto( # nolint
    `_class` = "LabelParams",
    `_inherit` = ggplot2::GeomText
  )

  geom_label_params <- function(
    data = NULL,
    stat = "identity",
    col_pos_vec = NULL,
    ...,
    position = "identity",
    parse = FALSE,
    nudge_x = 0,
    nudge_y = 0,
    label.padding = ggplot2::unit(0.25, "lines"), # nolint
    label.r = ggplot2::unit(0.15, "lines"), # nolint
    label.size = 0.25, # nolint
    na.rm = FALSE, # nolint
    show.legend = NA, # nolint
    inherit.aes = FALSE # nolint
  ) {

    # character / factor to integer
    data <- cat2integer(data)

    lapply(
      X = seq_len(length(col_pos_vec)),
      FUN = function(x) {
        colpos <- col_pos_vec[x]
        xpos <- x
        col_name <- colnames(data)[colpos]
        uniq_vals <- unique(data[, get(col_name)])

        plt_dat <- data.table::data.table(
          "original_values" = data[, get(col_name)],
          "normalized_values" = sts_normalize(data[, get(col_name)])
        )

        plt_dat <- plt_dat[, lapply(.SD, round, digits = 2)]
        # heuristic: always display 6 values
        if (length(uniq_vals) > 10) {
          new_breaks <- seq(
            from = plt_dat[, min(get("original_values"))],
            to = plt_dat[, max(get("original_values"))],
            length.out = 6
          )

          # get row indices of best matching values
          rids <- sapply(
            X = new_breaks,
            FUN = function(x) {
              which.min(abs(plt_dat[, get("original_values")] - x))
            },
            USE.NAMES = FALSE
          )

          plt_dat[
            rids,
            ("label_annot") := as.character(get("original_values"))
          ]
        } else {
          plt_dat[
            ,
            ("label_annot") := as.character(get("original_values"))
          ]
        }

        mapping <- ggplot2::aes(
          x = xpos,
          y = eval(parse(text = "normalized_values")),
          label = eval(parse(text = "label_annot"))
        )
        ggplot2::layer(
          data = plt_dat,
          stat = stat,
          mapping = mapping,
          geom = "text",
          position = position,
          show.legend = show.legend,
          inherit.aes = inherit.aes,
          params = list(na.rm = na.rm, ...),
        )
      })
  }
  return(list(LabelParams = LabelParams, geom_label_params = geom_label_params))
}


cat2integer <- function(data) {
  stopifnot("`data` must be a data.table" = data.table::is.data.table(data))
  data_copy <- data.table::copy(data)
  # character / factor to integer
  cat_vars <- colnames(data_copy)[
    data_copy[, vapply(.SD, function(x) {
      is.character(x) || is.factor(x)
    }, logical(1L))]
  ]
  if (length(cat_vars) > 0L) {
    data_copy[
      ,
      (cat_vars) := lapply(
        X = .SD,
        FUN = function(x) {
          as.integer(x) - 1L
        }),
      .SDcols = cat_vars
    ]
  }
  return(data_copy)
}
