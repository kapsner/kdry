#' @export
misc_argument_catcher <- function(...) {
  catch_args <- list(...)
  if ("..." %in% names(catch_args)) {
    catch_args <- catch_args[["..."]]
  }
  return(sapply(catch_args, list))
}
