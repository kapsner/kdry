#' @title rep_frac_pct
#'
#' @description Reporting helper function: computes and formats the relative
#'   percentage of a fraction.
#'
#' @param count A numeric. The numerator.
#' @param count_reference A numeric. The denominator.
#' @param brackets A character. Either `"round"` (default) or `"square"` to
#'   indicate the type of brackets to surround the relative count.
#' @param suffix A character which is placed between the lower and the upper
#'   confidence bound in the formatted output.
#'
#' @inheritParams rep_mean_sd
#'
#' @return A character with the formatted output.
#'
#' @seealso [stats::median], [stats::quantile], [Hmisc::wtd.quantile()]
#'
#' @examples
#' rep_frac_pct(count = 40, count_reference = 200)
#' rep_frac_pct(count = 40, count_reference = 200, brackets = "square")
#' rep_frac_pct(40, 200, brackets = "square", suffix = FALSE)
#'
#' @export
rep_frac_pct <- function(count,
                        count_reference,
                        digits = 2,
                        na.rm = TRUE, # nolint
                        brackets = c("round", "square"),
                        suffix = TRUE
) {
  stopifnot(
    "`count` and `count_reference` must be numeric of length() == 1" =
      sapply(c(count, count_reference),
             function(x) is.numeric(x) && length(x) == 1)
  )
  if (isTRUE(suffix)) {
    add_suffix <- "%"
  } else {
    add_suffix <- ""
  }

  pct <- (count / count_reference * 100) %>%
    round(digits = digits) %>%
    format(nsmall = digits, trim = TRUE)

  frac <- paste0(count, " / ", count_reference)

  return(rep_distribution_meta(
    central_tendency = frac,
    dispersion = pct,
    na.rm = na.rm,
    prefix = "",
    suffix = add_suffix,
    brackets = brackets
  ))
}
