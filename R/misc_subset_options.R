#' @title misc_subset_options
#'
#' @description Miscellaneous helper function to subset R options by a keyword.
#'
#' @param keyword A character. The keyword to subset the R options.
#'
#' @details This function subsets R's `options()` by a keyword. It returns a
#'   list of all available options that match with the `keyword`. The `keyword`
#'   is evaluated as a regular expression.
#'
#' @return A `list` is returned, containing the subset of R's `options()` that
#'   matches with the `keyword`.

#' @examples
#' misc_subset_options("default")
#' @export
#'
misc_subset_options <- function(keyword) {
  stopifnot(
    "`keyword` must be a character" = is.character(keyword),
    "`keyword` must be of length() == 1" = length(keyword) == 1L
  )
  relevant_option_pos <- grep(
    pattern = keyword,
    x = names(options()),
    value = FALSE
  )
  return(options()[relevant_option_pos])
}
