#' @export
plt_parallel_coordinates <- function(
    data,
    cols,
    color = NULL,
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
  if (!requireNamespace("viridis", quietly = TRUE)) {
    stop(
      paste0(
        "Package \"viridis\" must be installed to use ",
        "\"plt_parallel_coordinates\"."
      ),
      call. = FALSE
    )
  }
  vec <- colnames(data)[cols]
  data_copy <- data.table::copy(data)
  if (!is.null(color)) {
    data_copy <- data_copy[order(get(color), decreasing = TRUE)]
  }
  data_copy[
    ,
    (vec) := lapply(
      X = .SD,
      FUN = function(x) {
        stats_normalize(x) %>%
          round(digits = 3)
      }),
    .SDcols = vec
  ]
  data_copy$id <- rownames(data)
  data_copy <- data.table::melt.data.table(
    data = data_copy,
    id.vars = c("id", color),
    measure.vars = vec
  )
  #data_copy[, ("x") := as.integer(get("variable"))]

  data_copy %>%
    ggplot2::ggplot(
      ggplot2::aes_string(
        x = "variable",
        y = "value",
        color = color)
    ) +
    ggplot2::geom_line(
      ggplot2::aes_string(group = "id"),
      position = ggplot2::position_jitter(
        w = line_jitter[["w"]],
        h = line_jitter[["h"]]
      )
    ) +
    viridis::scale_color_viridis(
      option = "inferno",
      end = .1,
      begin = 0.9,
      alpha = 0.6
    ) +
    ggplot2::xlab("Hyperparameter") +
    ggplot2::ylab("Parameter value") +
    geom_label_params(
      data = data,
      col_pos_vec = cols,
      vjust = -0.5,
      size = text_label_size
    ) +
    ggplot2::theme(
      axis.text.y = ggplot2::element_blank()
    )
}

LabelParams <- ggplot2::ggproto(
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
    label.padding = unit(0.25, "lines"),
    label.r = unit(0.15, "lines"),
    label.size = 0.25,
    na.rm = FALSE,
    show.legend = NA,
    inherit.aes = FALSE
) {
  lapply(
    X = seq_len(length(col_pos_vec)),
    FUN = function(x) {
      colpos <- col_pos_vec[x]
      xpos <- x
      col_name <- colnames(data)[colpos]
      uniq_vals <- unique(data[, get(col_name)])

      plt_dat <- data.table::data.table(
        "original_values" = data[, get(col_name)],
        "normalized_values" = stats_normalize(data[, get(col_name)])
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
