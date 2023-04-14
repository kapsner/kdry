#' @title mlh_outsample_row_indices
#'
#' @description Machine learning helper function to convert a vector of (in-
#'   sample) row indices of a fold into out-of-sample row indices.
#'
#' @param fold_list A list of integer vectors that describe the row indices
#'   of cross-validation folds. The list must be named.
#' @param dataset_nrows An integer. The number of rows in the dataset
#'   dataset. This parameter is required in order to compute the out-of-sample
#'   row indices.
#' @param type A character. To be used if the out-of-sample row indices need to
#'   be formatted in a special manner (default: `NULL`). Currently, the only
#'   allowed value is `type = "glmnet"` in order to format the row indices as
#'   required by `glmnet::cv.glmnet`'s argument `foldid`.
#'
#' @return If `type = NULL`, returns a list of same length as `fold_list` with
#'   each item containing a vector of out-of-sample row indices. If
#'   `type = "glmnet"`, a data.table is returned with two columns and each row
#'   representing one observation of the dataset that is assigned to a specific
#'   test fold. The column "fold_id" should be passed further on to the argument
#'   `foldid` of `glmnet::cv.glmnet`.

#' @examples
#' fold_list <- list(
#'   "Fold1" = setdiff(seq_len(100), 1:33),
#'   "Fold2" = setdiff(seq_len(100),66:100),
#'   "Fold3" = setdiff(seq_len(100),34:65)
#' )
#' mlh_outsample_row_indices(fold_list, 100)
#' mlh_outsample_row_indices(fold_list, 100, "glmnet")
#' @export
#'
mlh_outsample_row_indices <- function(
    fold_list,
    dataset_nrows,
    type = NULL
  ) {
  stopifnot(
    "`fold_list` needs to be a `list()-object`"  = is.list(fold_list),
    "`fold_list` must contain at least one item"  = length(fold_list) > 0L,
    "`dataset_nrows` must be an integer" = is.integer(
      as.integer(dataset_nrows)
    ),
    "Please provide exactly one number for `dataset_nrows`" =
      length(dataset_nrows) == 1L,
    "`type` must be `'glmne '`" =
      ifelse(is.null(type), TRUE, type %in% c("glmnet")),
    "`fold_list` must contain at least one named item" =
      length(names(fold_list)) > 0L
  )
  dataset_nrows <- as.integer(dataset_nrows)

  fold_ids <- sapply(
    X = names(fold_list),
    FUN = function(x) {
      in_sample_ids <- fold_list[[x]]
      setdiff(seq_len(dataset_nrows), in_sample_ids)
    },
    simplify = FALSE,
    USE.NAMES = TRUE
  )

  if (is.null(type)) {
    stopifnot(
      "Length of `fold_ids` is not equal to length of `fold_list`" =
        length(fold_ids) == length(fold_list))
    return(fold_ids)
  } else if (type == "glmnet") {
    # assign each row of the dataset to a specific test fold
    fids <- data.table::data.table()

    for (fid in seq_along(fold_ids)) {
      fids <- data.table::rbindlist(
        l = list(
          fids,
          data.table::data.table(
            "row_id" = fold_ids[[fid]],
            "fold_id" = fid
          )
        )
      )
    }
    fids <- fids[order(get("row_id"))]
    stopifnot(
      "Duplicates occurred in `row_id`" = !any(duplicated(fids$row_id)),
      "Lenght of unique `fold_id`s is not equal to number of provided folds" =
        length(unique(fids$fold_id)) == length(fold_list),
      "Number of fold ids needs to match number of observations in the dataset"
      = nrow(fids) == dataset_nrows
    )
    return(fids)
  } else {
    stop(paste0("Type '", type, "' not implemented."))
  }
}
