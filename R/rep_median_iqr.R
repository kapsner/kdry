#' @title rep_median_iqr
#'
#' @description Reporting helper function: computes and formats median and
#'   interquartile range from a numeric vector.
#'
#' @details This is just a special case of [rep_median_ci()] with the parameter
#'   `conf_int` set to `50`.
#'
#' @inheritParams rep_median_ci
#'
#' @return A character with the formatted output.
#'
#' @seealso [rep_median_ci()]
#'
#' @examples
#' set.seed(123)
#' x <- rnorm(1000)
#' rep_median_iqr(x)
#' rep_median_iqr(rep(1, 10))
#' rep_median_iqr(x, collapse = "-")
#' rep_median_iqr(x, iqr_brackets = "square")
#' rep_median_iqr(x, iqr_brackets = "square", iqr_prefix = FALSE)
#' rep_median_iqr(x, collapse = ";", iqr_prefix = FALSE)
#'
#' @export
# median/iqr-wrapper (special case of rep-median-ci)
rep_median_iqr <- function(x,
                           digits = 2,
                           na.rm = TRUE, # nolint
                           collapse = "to",
                           iqr_brackets = c("round", "square"),
                           iqr_prefix = TRUE
) {
  return(rep_median_ci(
    x = x,
    conf_int = 50,
    digits = digits,
    na.rm = na.rm,
    collapse = collapse,
    iqr_brackets = iqr_brackets,
    iqr_prefix = iqr_prefix,
    weighted = FALSE,
    weights = NA
  ))
}
