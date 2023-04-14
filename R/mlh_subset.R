#' @title mlh_subset
#'
#' @description Machine learning helper function to select a subset from a
#'   data matrix or a response vector.
#'
#' @param object A vector or a data matrix. Supports also subsetting of "Surv"
#'   objects.
#' @param ids An integer vector specifying the indices that should be selected
#'   from the object.
#'
#' @return Returns the specified subset of the object.

#' @examples
#' data("iris")
#' mlh_subset(iris, c(1:30))
#' mlh_subset(iris[, 5], c(1:30))
#' @export
#'
mlh_subset <- function(object, ids) {
  stopifnot("`ids` must be an integer" = is.integer(ids))
  if (is.null(dim(object)) && is.atomic(object)) {
    return(object[ids])
  } else {
    stopifnot(
      "`object` must be either a matrix, a data.frame or a \
      survial::Surv object" =
        inherits(object, "matrix") || inherits(object, "data.frame") ||
        inherits(object, "Surv")
    )
    if (inherits(object, "matrix") || inherits(object, "data.frame")) {
      obj <- data.table::as.data.table(object)[ids, ]
      if (inherits(object, "matrix")) {
        return(as.matrix(obj))
      } else if (inherits(object, "data.frame")) {
        return(as.data.frame(obj))
      }
    } else if (inherits(object, "Surv")) {
      if (!requireNamespace("survival", quietly = TRUE)) {
        stop(
          paste0(
            "Package \"survival\" must be installed to use ",
            "\"mlh_subset\" with objects of type \"Surv\"."
          ),
          call. = FALSE
        )
      }
      surv_attr <- attributes(object)
      arg_list <- surv_attr["type"]
      arg_list <- list.append(
        arg_list,
        sapply(
          X = surv_attr$dimnames[[2]],
          FUN = function(dn) {
            object[ids, dn]
          },
          simplify = FALSE,
          USE.NAMES = TRUE
        )
      )
      # rename 'status' to 'event'
      arg_list[["event"]] <- arg_list[["status"]]
      arg_list[["status"]] <- NULL
      # also rename time1, when present
      if ("time1" %in% names(arg_list)) {
        arg_list[["time"]] <- arg_list[["time1"]]
        arg_list[["time1"]] <- NULL
      }
      ret <- do.call(survival::Surv, arg_list)
      stopifnot(
        identical(
          attributes(object)[!names(object) == "dim"],
          attributes(ret)[!names(ret) == "dim"]
        )
      )
      return(ret)
    }
  }
}
