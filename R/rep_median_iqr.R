#' rep_median_iqr
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
# median/iqr-wrapper
rep_median_iqr <- function(x,
                           digits = 2,
                           na.rm = TRUE,
                           collapse = "to",
                           iqr_brackets = c("round", "square"),
                           iqr_prefix = TRUE
) {
  stopifnot(
    is.character(collapse)
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

  # Quantiles
  qa <- stats::quantile(x = x, probs = c(0.25, 0.75), na.rm = na.rm) %>%
    round(digits = digits) %>%
    format(nsmall = digits, trim = TRUE)
  # Median
  med <- stats::median(x, na.rm = TRUE) %>%
    round(digits = digits) %>%
    format(nsmall = digits, trim = TRUE) %>%
    remove_all_zero_digits_after_dec()

  return(rep_distribution_meta(
    central_tendency = med,
    dispersion = paste0(qa[1], collapse, qa[2]),
    digits = digits,
    na.rm = na.rm,
    prefix = qa_prefix,
    brackets = iqr_brackets
  ))
}
