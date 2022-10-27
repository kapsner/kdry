#' @title mlh_format_xy
#'
#' @description Machine learning helper function to select a subset from a
#'   data matrix or a response vector.
#'
#' @param object A vector or a data matrix.
#' @param ids An integer vector specifying the indices that should be selected
#'   from the object.
#'
#' @return Returns a subset of object.

#' @examples
#' data("iris")
#' mlh_format_xy(iris, c(1:30))
#' mlh_format_xy(iris[, 5], c(1:30))
#' @export
#'
mlh_format_xy <- function(object, ids) {
  stopifnot(is.integer(ids), is.matrix(object) || is.data.frame(object))
  if (is.null(dim(object)) && is.atomic(object)) {
    return(object[ids])
  } else {
    return(object[ids, ])
  }
}
