#' @title pch_register_parallel
#'
#' @description Parallel computing helper function to register a parallel
#'   backend.
#'
#' @inheritParams pch_check_available_cores
#'
#' @return The function returns a object of class `c("SOCKcluster", "cluster")`,
#'   created with `parallel::makePSOCKcluster()`.
#'
#' @seealso [parallel::makePSOCKcluster()], [doParallel::registerDoParallel()]

#' @examples
#' cl <- pch_register_parallel(pch_check_available_cores(2))
#' pch_clean_up(cl)
#' @export
#
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
