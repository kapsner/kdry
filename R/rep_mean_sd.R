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
                        sd_prefix = TRUE
) {
  if (isTRUE(sd_prefix)) {
    sd_prefix <- "\u00B1"
  } else {
    sd_prefix <- ""
  }

  # SD
  sd <- stats::sd(x = x, na.rm = na.rm) %>%
    round(digits = digits) %>%
    format(nsmall = digits, trim = TRUE)
  # Mean
  mea <- mean(x, na.rm = TRUE) %>%
    round(digits = digits) %>%
    format(nsmall = digits, trim = TRUE) %>%
    remove_all_zero_digits_after_dec()

  return(rep_distribution_meta(
    central_tendency = mea,
    dispersion = sd,
    digits = digits,
    na.rm = na.rm,
    prefix = sd_prefix,
    brackets = sd_brackets
  ))
}
