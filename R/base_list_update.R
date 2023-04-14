#' @title list.update
#'
#' @description Helper function to update items in an R list.
#'
#' @param main_list A list, which items should be updated.
#' @param new_list A list with new values of items ffrom `main_list` that should
#'   be updated. All names of `new_list` must be present in `main_list`.
#' @inheritParams list.append
#'
#' @details This function is a save wrapper around `utils::modifyLists` to
#'   update items in R lists as it checks for the input types and only accepts
#'   named lists.
#'
#' @return A `list` is returned.
#'
#' @seealso [utils::modifyList()]
#'
#' @examples
#' l1 <- list("a" = 1, "b" = 2)
#' l2 <- list("a" = 3, "b" = 4)
#' list.update(l1, l2)
#' @export
#'
list.update <- function(main_list, new_list, ...) { # nolint
  stopifnot(
    "`new_list` needs to be a list()-object"  = is.list(new_list),
    "`main_list` needs to be a list()-object" = is.list(main_list),
    "All names of `new_list` must exist in `main_list`" = identical(
      intersect(names(new_list), names(main_list)), names(new_list)
    )
  )
  return(list.append(main_list = main_list, append_list = new_list, ...))
}
