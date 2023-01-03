#' rep_sum_pct
#'
#' @examples
#' rep_sum_pct(count = 40, count_reference = 200)
#' rep_sum_pct(count = 40, count_reference = 200, brackets = "square")
#' rep_sum_pct(count = 40, count_reference = 200, brackets = "square", suffix = FALSE)
#'
#' @export
# mean/sd-wrapper
rep_sum_pct <- function(count,
                        count_reference,
                        digits = 2,
                        na.rm = TRUE,
                        brackets = c("round", "square"),
                        suffix = TRUE
) {
  if (isTRUE(suffix)) {
    add_suffix <- "%"
  } else {
    add_suffix <- ""
  }

  pct <- (count / count_reference * 100) %>%
    round(digits = digits) %>%
    format(nsmall = digits, trim = TRUE)

  return(rep_distribution_meta(
    central_tendency = count,
    dispersion = pct,
    na.rm = na.rm,
    prefix = "",
    suffix = add_suffix,
    brackets = brackets
  ))
}
