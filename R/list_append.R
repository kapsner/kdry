#' @export
list.append <- function(main_list, append_list) { # nolint
stopifnot(is.list(main_list), is.list(append_list) || is.null(append_list))
if (length(append_list) > 0L) {
  main_list <- c(main_list, append_list)
}
return(main_list)
}
