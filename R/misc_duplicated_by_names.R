#' @title misc_duplicated_by_names
#'
#' @description Miscellaneous helper function to detect items in an object
#'   with duplicated names, e.g. in named vectors or named lists.
#'
#' @param object An R object that has names.
#' @param ... Named arguments passed on to `duplicated`.
#'
#' @return Returns a logical vector of `length(object)` with `TRUE` indicating
#'   the identified items with duplicated names.
#'
#' @seealso [base::duplicated()]

#' @examples
#' misc_duplicated_by_names(list(a = 1, a = 1))
#' @export
#'
misc_duplicated_by_names <- function(object, ...) {
  stopifnot(
    "`object` must have names, i.e. `names(object)` must return a \
    character vector" = !is.null(names(object)),
    "`object` must have at least 1 name" = length(names(object)) > 0L
  )
  return(duplicated(x = names(object), ...))
}
