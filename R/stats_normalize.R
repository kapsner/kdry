#' @export
stats_normalize <- function(x, na.rm = TRUE) {
  return((x - min(x)) / (max(x) - min(x)))
}
