#' @title sts_normalize
#'
#' @description Statistic helper function to normalize a continuous variable
#'   between zero and one.
#'
#' @param x A vector of type `numeric`.
#' @param na.rm A logical to indicate, if missings should be removed.
#'
#' @return Returns a vector of same length as `x` with values normalized between
#'   zero and one. If `x` contains missings and `na.rm = TRUE`, the missings are
#'   removed before normalization; otherwise, a vector of `NA` is returend.

#' @examples
#' sts_normalize(1:100)
#' @export
#
sts_normalize <- function(x, na.rm = FALSE) { # nolint
  stopifnot(
    "`x` must be numeric" = is.numeric(x),
    "Length of `x` must be > 1" = length(x) > 1L,
    "`x` must be a vector" = is.vector(x),
    "`na.rm` must be a boolean" = is.logical(na.rm))
  if (na.rm) {
    x <- x[!is.na(x)]
  }
  return((x - min(x)) / (max(x) - min(x)))
}
