#' @title rep_median_ci
#'
#' @description Reporting helper function: computes and formats median and
#'   confidence interval from a numeric vector.
#'
#' @param conf_int A numeric between 0 and 100 to indicate the confidence
#'   interval that should be computed.
#' @param collapse A character which is placed between the lower and the upper
#'   confidence bound in the formatted output.
#' @param iqr_brackets A character. Either `"round"` (default) or `"square"` to
#'   indicate the type of brackets to surround the confidence interval in the
#'   formatted output.
#' @param iqr_prefix A logical. If `TRUE` (default), the confidence interval is
#'   prefixed with `"IQR: "`.
#' @param weighted A logical. If `TRUE`, a weighted median and confidence
#'   interval are calculated (default: `FALSE`).
#' @param weights A numeric vector of weights passed further on to
#'   [Hmisc::wtd.quantile()] if `weighted = TRUE` (default: `NA`).
#'
#' @inheritParams rep_mean_sd
#'
#' @return A character with the formatted output.
#'
#' @seealso [stats::median], [stats::quantile], [Hmisc::wtd.quantile()]
#'
#' @examples
#' set.seed(123)
#' x <- rnorm(1000)
#' rep_median_ci(x, conf_int = 95)
#' rep_median_ci(rep(1, 10), conf_int = 95)
#' rep_median_ci(x, conf_int = 95, collapse = "-")
#' rep_median_ci(x, iqr_brackets = "square", conf_int = 50)
#'
#' @export
rep_median_ci <- function(x,
                          conf_int,
                          digits = 2,
                          na.rm = TRUE, # nolint
                          collapse = "to",
                          iqr_brackets = c("round", "square"),
                          iqr_prefix = TRUE,
                          weighted = FALSE,
                          weights = NA
) {
  stopifnot(
    "`conf_int` must be of length() == 1" = length(conf_int) == 1,
    "`x` must be numeric" = is.numeric(x),
    "`collapse` must be a character" = is.character(collapse),
    "`conf_int` must be in range between 0 and 100" =
      conf_int > 0 && conf_int < 100,
    "`weighted` must be a boolean" = is.logical(weighted),
    "`weights` must be a numeric vector" =
      ifelse(weighted, is.vector(weights), TRUE)
  )
  if (isTRUE(iqr_prefix)) {
    qa_prefix <- "IQR: "
  } else {
    qa_prefix <- ""
  }
  if (gsub(pattern = "\\s", replacement = "", x = collapse) %in% c("to", "-")) {
    # normalize empty space before and after collapse
    collapse <- gsub(pattern = "\\s", replacement = "", x = collapse)
    collapse <- paste0(" ", collapse, " ")
  } else if (gsub(pattern = "\\s", replacement = "", x = collapse) %in%
             c(";", ",")) {
    collapse <- gsub(pattern = "\\s", replacement = "", x = collapse)
    collapse <- paste0(collapse, " ")
  }

  # compute upper and lower limits of conf-int
  ci_format <- ((100 - conf_int) / 2) / 100
  ci_upper <- 1 - ci_format
  ci_lower <- 0 + ci_format


  if (isFALSE(weighted)) {
    # Quantiles
    qa <- stats::quantile(x = x,
                          probs = c(ci_lower, ci_upper),
                          na.rm = na.rm) %>%
      round(digits = digits) %>%
      format(nsmall = digits, trim = TRUE)
    stopifnot(length(qa) == 2)
    # Median
    med <- stats::median(x, na.rm = TRUE) %>%
      round(digits = digits) %>%
      format(nsmall = digits, trim = TRUE) %>%
      remove_all_zero_digits_after_dec()
  } else {
    wt_quantiles <- Hmisc::wtd.quantile(
      x = x,
      weights = weights,
      probs = c(ci_lower, 0.5, ci_upper),
      na.rm = na.rm
    ) %>%
      round(digits = digits) %>%
      format(nsmall = digits, trim = TRUE)
    stopifnot(length(wt_quantiles) == 3)
    qa <- c(wt_quantiles[1], wt_quantiles[3])
    med <- wt_quantiles[2]
  }

  return(rep_distribution_meta(
    central_tendency = med,
    dispersion = paste0(qa[1], collapse, qa[2]),
    na.rm = na.rm,
    prefix = qa_prefix,
    suffix = "",
    brackets = iqr_brackets
  ))
}
