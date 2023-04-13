#' @title rep_mean_sd
#'
#' @description Reporting helper function: computes and formats mean and
#'   standard deviation from a numeric vector.
#'
#' @param x A numeric vector.
#' @param digits An integer indicating the number of decimal places.
#' @param na.rm A logical indicating if missings should be removed from `x`
#'   before computing the distributional parameters (default: `TRUE`).
#' @param sd_brackets A character. Either `"round"` (default) or `"square"` to
#'   indicate the type of brackets to surround the standard deviation in the
#'   formatted output.
#' @param sd_prefix A logical. If `TRUE` (default), the standard deviation is
#'   prefixed with a plus-minus-sign ("&#177;").
#' @param weighted A logical. If `TRUE`, a weighted mean and standard deviation
#'   are calculated (default: `FALSE`).
#' @param weights A vector with the weights (if `weighted = TRUE`;
#'   default: `NA`) passed futher on to [stats::weighted.mean()] and
#'   [Hmisc::wtd.var()].
#'
#' @return A character with the formatted output.
#'
#' @seealso [mean()], [stats::sd()], [stats::weighted.mean()],
#'   [Hmisc::wtd.var()]
#'
#' @examples
#' set.seed(123)
#' x <- rnorm(1000)
#' rep_mean_sd(x)
#' rep_mean_sd(rep(1, 10))
#' rep_mean_sd(x, sd_brackets = "square")
#' rep_mean_sd(x, sd_brackets = "square", sd_prefix = FALSE)
#'
#' @export
rep_mean_sd <- function(x,
                        digits = 2,
                        na.rm = TRUE, # nolint
                        sd_brackets = c("round", "square"),
                        sd_prefix = TRUE,
                        weighted = FALSE,
                        weights = NA
) {
  stopifnot(
    "`x` must be a numeric vector" = is.numeric(x),
    "`weighted` must be a boolean" = is.logical(weighted),
    "`weights` must be a vector" = ifelse(weighted, is.vector(weights), TRUE)
  )
  if (isTRUE(sd_prefix)) {
    sd_prefix <- "\u00B1"
  } else {
    sd_prefix <- ""
  }

  if (isFALSE(weighted)) {
    sd <- stats::sd(x = x, na.rm = na.rm) %>%
      round(digits = digits) %>%
      format(nsmall = digits, trim = TRUE)
    mea <- mean(x, na.rm = TRUE) %>%
      round(digits = digits) %>%
      format(nsmall = digits, trim = TRUE)
  } else {
    sd <- Hmisc::wtd.var(x = x, weights = weights, na.rm = na.rm) %>%
      sqrt() %>%
      round(digits = digits) %>%
      format(nsmall = digits, trim = TRUE)
    mea <- stats::weighted.mean(x = x, w = weights, na.rm = na.rm) %>%
      round(digits = digits) %>%
      format(nsmall = digits, trim = TRUE)
  }

  return(rep_distribution_meta(
    central_tendency = mea,
    dispersion = sd,
    na.rm = na.rm,
    prefix = sd_prefix,
    suffix = "",
    brackets = sd_brackets
  ))
}
