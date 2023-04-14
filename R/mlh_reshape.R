#' @title mlh_reshape
#'
#' @description Machine learning helper function to reshape a matrix of
#'   predicted probabilities to classes.
#'
#' @param object A matrix with predicted probabilities for several classes.
#'   Each row must sum up to 1.
#'
#' @return Returns a vector of type factor of the same length as rows in object,
#'   representing the class with the highest probability for each observation in
#'   object.

#' @examples
#' set.seed(123)
#' class_0 <- rbeta(100, 2, 4)
#' class_1 <- (1 - class_0) * 0.4
#' class_2 <- (1 - class_0) * 0.6
#' dataset <- cbind("0" = class_0, "1" = class_1, "2" = class_2)
#' mlh_reshape(dataset)
#' @export
#'
mlh_reshape <- function(object) {
  stopifnot(
    "`object` needs to have at least 2 columns" = dim(object)[2] > 1L,
    "Rows do not sum up to 1" = all(abs(1L - rowSums(object)) < 1e-06)
  )
  cn <- colnames(object)
  if (is.null(cn)) {
    cn <- paste0(seq_len(dim(object)[2]) - 1L)
    colnames(object) <- cn
  }
  preds <- data.table::as.data.table(object)[
    , cn[which.max(.SD)], by = seq_len(nrow(object))
  ][, get("V1")]
  preds <- factor(preds, levels = cn)
  return(preds)
}
