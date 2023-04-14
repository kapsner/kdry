#' @title list.append
#'
#' @description Helper function to append an R list.
#'
#' @param main_list A list, to which another should be appended.
#' @param append_list A list to append to `main_list` (can be `NULL` or empty).
#' @param ... Further arguments passed to `utils::modifyList()`.
#'
#' @details This function is a save wrapper around `utils::modifyLists` to
#'   combine lists as it checks for the input types and only appends the new
#'   list if its length is greater than 0.
#'
#' @return A `list` is returned.
#'
#' @seealso [utils::modifyList()]
#'
#' @examples
#' l1 <- list("a" = 1, "b" = 2)
#' l2 <- list("c" = 3, "d" = 4)
#' list.append(l1, l2)
#' @export
#'
list.append <- function(main_list, append_list, ...) { # nolint
  stopifnot(
    "`main_list` needs to be a list()-object" = is.list(main_list),
    "`append_list` needs to be either a list()-object or empty" =
      is.list(append_list) || is.null(append_list))
  if (length(append_list) > 0L) {
    main_list <- utils::modifyList(x = main_list, val = append_list, ...)
  }
return(main_list)
}
