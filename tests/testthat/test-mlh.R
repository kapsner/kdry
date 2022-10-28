test_that(
  desc = "test mlh - mlh_outsample_row_indices",
  code = {

    fold_list <- list(
      "Fold1" = setdiff(seq_len(100), 1:33),
      "Fold2" = setdiff(seq_len(100), 66:100),
      "Fold3" = setdiff(seq_len(100), 34:65)
    )
    l1 <- mlh_outsample_row_indices(fold_list, 100)
    expect_type(l1, "list")
    expect_length(l1, 3)

    l2 <- mlh_outsample_row_indices(fold_list, 100, "glmnet")
    expect_s3_class(l2, "data.table")
    expect_true(nrow(l2) == 100)
  }
)

test_that(
  desc = "test mlh - mlh_subset",
  code = {

    data("iris")
    d1 <- mlh_subset(iris, c(1:30))
    expect_equal(dim(d1), c(30, 5))
    d2 <- mlh_subset(iris[, 5], c(1:30))
    expect_true(is.atomic(d2))
    expect_length(d2, 30)

    expect_error(mlh_subset(iris, c(TRUE, TRUE, FALSE)))
    expect_error(mlh_subset(list(), c(1:30)))
  }
)
