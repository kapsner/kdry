#' @export
misc_subset_option <- function(keyword) {
  relevant_option_pos <- grep(
    pattern = keyword,
    x = names(options()),
    value = FALSE
  )
  return(options()[relevant_option_pos])
}
