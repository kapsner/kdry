#' @title mlh_subset
#'
#' @description Machine learning helper function to select a subset from a
#'   data matrix or a response vector.
#'
#' @param object A vector or a data matrix.
#' @param ids An integer vector specifying the indices that should be selected
#'   from the object.
#'
#' @return Returns the specified subset of the object.

#' @examples
#' data("iris")
#' mlh_subset(iris, c(1:30))
#' mlh_subset(iris[, 5], c(1:30))
#' @export
#'
mlh_subset <- function(object, ids) {
  stopifnot(is.integer(ids))
  if (is.null(dim(object)) && is.atomic(object)) {
    return(object[ids])
  } else {
    stopifnot(inherits(object, "matrix") || inherits(object, "data.frame"))
    return(object[ids, ])
  }
}
