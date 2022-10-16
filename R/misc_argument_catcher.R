#' @title misc_argument_catcher
#'
#' @description Miscellaneous helper function to type-save catch arguments
#'   passed with R's ellipsis ("...").
#'
#' @param ... Named arguments passed to a function.
#'
#' @details This function aims at catching arguments that have been passed to an
#'   R function using R's ellipsis ("..."). Its purpos is to catch these
#'   arguments even in the case, if a list with arguments was provided to the
#'   ellipsis.
#'
#' @return A `list` is returned.

#' @examples
#' misc_argument_catcher(a = 1)
#' misc_argument_catcher(a = 1, b = 2, c = 3, d = "car")
#' misc_argument_catcher(list(a = 1, b = 2, c = 3, d = "car"))
#' misc_argument_catcher(list(a = 1, b = 2, c = 3, d = "car"), f = 9)
#' @export
#'
misc_argument_catcher <- function(...) {
  catch_args <- list(...)
  if ("..." %in% names(catch_args)) {
    catch_args <- catch_args[["..."]]
  }

  outlist <- list()

  for (item_i in seq_len(length(catch_args))) {
    item <- catch_args[[item_i]]
    item_name <- names(catch_args)[item_i]
    if (is.list(item)) {
      append_item <- item
    } else {
      append_item <- list()
      append_item[[item_name]] <- item
    }
    outlist <- list.append(outlist, append_item)
  }
  return(outlist)
}
