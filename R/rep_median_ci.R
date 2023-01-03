#' rep_median_ci
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
# median/ci-wrapper
rep_median_ci <- function(x,
                          conf_int,
                          digits = 2,
                          na.rm = TRUE,
                          collapse = "to",
                          iqr_brackets = c("round", "square"),
                          iqr_prefix = TRUE,
                          weighted = FALSE,
                          weights = NA
) {
  stopifnot(
    is.character(collapse),
    conf_int > 1 && conf_int < 100,
    is.logical(weighted), ifelse(weighted, is.vector(weights), TRUE)
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
    )
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
