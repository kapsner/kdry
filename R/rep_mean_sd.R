#' rep_mean_sd
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
# mean/sd-wrapper
rep_mean_sd <- function(x,
                        digits = 2,
                        na.rm = TRUE,
                        sd_brackets = c("round", "square"),
                        sd_prefix = TRUE,
                        weighted = FALSE,
                        weights = NA
) {
  stopifnot(is.logical(weighted), ifelse(weighted, is.vector(weights), TRUE))
  if (isTRUE(sd_prefix)) {
    sd_prefix <- "\u00B1"
  } else {
    sd_prefix <- ""
  }

  # SD
  if (isFALSE(weighted)) {
    sd <- stats::sd(x = x, na.rm = na.rm) %>%
      round(digits = digits) %>%
      format(nsmall = digits, trim = TRUE)
  } else {
    sd <- Hmisc::wtd.var(x = x, weights = weights, na.rm = na.rm) %>%
      sqrt()
  }
  # Mean
  if (isFALSE(weighted)) {
    mea <- mean(x, na.rm = TRUE) %>%
      round(digits = digits) %>%
      format(nsmall = digits, trim = TRUE)
  } else {
    mea <- weighted.mean(x = x, w = weights, na.rm = na.rm)
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
