# wrapper function to register a parallel backend (and to avoid redundant code)
#' @export
pch_register_parallel <- function(ncores) {
  if (!requireNamespace("parallel", quietly = TRUE)) {
    stop(
      paste0(
        "Package \"parallel\" must be installed to use ",
        "\"pch_register_parallel\"."
      ),
      call. = FALSE
    )
  }
  if (!requireNamespace("doParallel", quietly = TRUE)) {
    stop(
      paste0(
        "Package \"doParallel\" must be installed to use ",
        "\"pch_register_parallel\"."
      ),
      call. = FALSE
    )
  }
  stopifnot(is.integer(as.integer(ncores)))
  ncores <- as.integer(ncores)
  cl <- parallel::makePSOCKcluster(ncores)
  doParallel::registerDoParallel(cl)
  return(cl)
}
