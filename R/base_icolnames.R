#' @title icolnames
#'
#' @description Return colnames in a table with index numbers.
#'
#' @param df A data.frame object.
#'
#' @return A `data.table` with the two columns `index` and `name` is returned.

#' @examples
#' data("iris")
#' icolnames(iris)
#' @export
#'
icolnames <- function(df) {
  stopifnot("`df` should be a data.frame" = is.data.frame(df))
  cn <- colnames(df)
  out_df <- data.table::data.table(
    index = seq_along(cn),
    names = cn
  )
  return(out_df)
}
