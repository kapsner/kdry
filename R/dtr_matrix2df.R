#' @title dtr_matrix2df
#'
#' @description Data transformation: Converts a `matrix` to `data.table` and
#'   encodes categorical variables as `factor`.
#'
#' @param matrix An R `matrix` object.
#' @param cat_vars A character vector with colnames that should be converted to
#'   `factor` (default: NULL).
#'
#' @return A `data.table` is returned.

#' @examples
#' data("iris")
#' mat <- data.matrix(iris)
#' dataset <- dtr_matrix2df(mat)
#' str(dataset)
#'
#' dataset <- dtr_matrix2df(mat, cat_vars = "Species")
#' str(dataset)
#' @export
#'
dtr_matrix2df <- function(matrix, cat_vars = NULL) {
  stopifnot(
    "`x` must be a matrix object" = inherits(
      x = matrix, what = c("matrix", "array")
    ),
    "`cat_vars` must be a character" = ifelse(
      !is.null(cat_vars), is.character(cat_vars), TRUE
    ),
    "The names of `cat_vars` must exist in colnames(matrix)" = intersect(
      cat_vars, colnames(matrix)) == cat_vars
  )
  matrix_dt <- data.table::as.data.table(matrix)
  if (!is.null(cat_vars)) {
    matrix_dt[
      ,
      (cat_vars) := lapply(X = .SD, FUN = factor),
      .SDcols = cat_vars
    ]
  }
  return(matrix_dt)
}
