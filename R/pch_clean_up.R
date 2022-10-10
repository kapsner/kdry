#' @export
pch_clean_up <- function(cl) {
  if (!requireNamespace("parallel", quietly = TRUE)) {
    stop(
      paste0(
        "Package \"parallel\" must be installed to use ",
        "\"pch_clean_up\"."
      ),
      call. = FALSE
    )
  }
  if (!requireNamespace("foreach", quietly = TRUE)) {
    stop(
      paste0(
        "Package \"foreach\" must be installed to use ",
        "\"pch_clean_up\"."
      ),
      call. = FALSE
    )
  }
  parallel::stopCluster(cl)
  foreach::registerDoSEQ()
  invisible()
}
