#' @title rep_pval
#'
#' @description Reporting helper function: formats p-value.
#'
#' @param p The p-value that should be formatted.
#' @param threshold A threshold to indicate that only "< threshold" is
#'   printed as output (default: 0.001).
#' @param digits The number of digits of the formatted p-value (digits).
#'
#' @return A character with the formatted p-value.
#'
#' @details If the p-value is lower than the threshold, the output of the
#'   function is "< threshold". Otherwise, the p-value is formatted to the
#'   number of digits.
#'
#' @examples
#' rep_pval(0.032)
#' rep_pval(0.00032)
#'
#' @export
rep_pval <- function(
    p,
    threshold = 0.001,
    digits = 3L
) {
  stopifnot(
    "`p` must be numeric" = is.numeric(p),
    "`p` must be in range between 0 and 1" = p <= 1.0 && p >= 0,
    "`threshold` must be numeric" = is.numeric(threshold),
    "`threshold` must be in range between 0 and 1" =
      threshold <= 1.0 && threshold >= 0,
    "`digits` must be an integer" = is.integer(digits)
  )

  if (p < threshold) {
    threshold <- threshold %>%
      round(digits = digits) %>%
      format(
        scientific = FALSE,
        nsmall = digits
      )
    pval <- paste0("<", threshold)
  } else {
    pval <- p %>%
      round(digits = digits) %>%
      format(
        scientific = FALSE,
        nsmall = digits
      )
  }
  return(pval)
}
