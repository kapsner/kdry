#' @export
pch_clean_up <- function(cl) {
  parallel::stopCluster(cl)
  foreach::registerDoSEQ()
  invisible()
}
