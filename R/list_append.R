#' @title list.append
#'
#' @description Helper function to append an R list.
#'
#' @param main_list A list, to which another should be appended.
#' @param append_list A list to append to `main_list` (can be `NULL` or empty).
#'
#' @details This function is a save wrapper around combining lists with `c()`
#'   as it checks for the input types and only appends the new list if its
#'   length is greater than 0.
#'
#' @return A `list` is returned.

#' @examples
#' l1 <- list("a" = 1, "b" = 2)
#' l2 <- list("c" = 3, "d" = 4)
#' list.append(l1, l2)
#' @export
#'
list.append <- function(main_list, append_list) { # nolint
  stopifnot(is.list(main_list), is.list(append_list) || is.null(append_list))
  if (length(append_list) > 0L) {
    main_list <- c(main_list, append_list)
  }
return(main_list)
}
