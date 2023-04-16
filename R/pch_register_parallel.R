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
#' if (require("doParallel") && require("foreach")) {
#'   cl <- pch_register_parallel(pch_check_available_cores(2))
#'   pch_clean_up(cl)
#' }
#' @export
#
pch_register_parallel <- function(ncores) {
  stopifnot("`ncores` must be an integer" = is.integer(as.integer(ncores)))
  ncores <- as.integer(ncores)
  cl <- parallel::makePSOCKcluster(names = ncores)
  doParallel::registerDoParallel(cl = cl)
  return(cl)
}
