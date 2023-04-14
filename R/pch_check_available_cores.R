#' @title pch_check_available_cores
#'
#' @description Parallel computing helper function to check for the available
#'   cores.
#'
#' @param ncores An integer. A number of cores requested for parallel computing
#'   (default: `-1L`).
#'
#' @return The function returns an integer that indicates the number of cores
#'   available. If `ncores <= parallel::detectCores()` the function returns
#'   `ncores`. If `ncores > parallel::detectCores()`, the function returns
#'   `parallel::detectCores() - 1L`.

#' @examples
#' pch_check_available_cores(2)
#' @export
#
pch_check_available_cores <- function(ncores = -1L) {
  stopifnot("`ncores` must be an integer" = is.integer(as.integer(ncores)))
  ncores <- as.integer(ncores)
  available_cores <- parallel::detectCores()

  if (ncores < 0L) {
    ncores_out <- available_cores
  } else if (ncores > 1L) {
    if (ncores > available_cores) {
      message(sprintf(
        paste0(
          "Number of specified cores ('%s') > available cores ('%s')...\n",
          "Setting cores to available cores - 1, i.e. '%s'."),
        ncores, available_cores, I(available_cores - 1L)
      ))
      ncores_out <- available_cores - 1L
    } else {
      ncores_out <- ncores
    }
  } else {
    ncores_out <- 1L
  }
  return(ncores_out)
}
