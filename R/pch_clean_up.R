#' @title pch_clean_up
#'
#' @description Parallel computing helper function to clean up the parallel
#'   backend.
#'
#' @param cl A cluster object of class `c("SOCKcluster", "cluster")`.
#'
#' @return The function returns nothing. Internally, it calls
#'   `parallel::stopCluster()` and `foreach::registerDoSEQ()`.
#'
#' @seealso [parallel::stopCluster()], [foreach::registerDoSEQ()]

#' @examples
#' if (require("doParallel") && require("foreach")) {
#'   cl <- pch_register_parallel(pch_check_available_cores(2))
#'   pch_clean_up(cl)
#' }
#' @export
#
pch_clean_up <- function(cl) {
  stopifnot(
    "`cluster` must be a SOCKcluster object" =
      inherits(cl, c("SOCKcluster", "cluster")))
  parallel::stopCluster(cl = cl)
  foreach::registerDoSEQ()
  invisible()
}
