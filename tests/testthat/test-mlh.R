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

    # with surv-objects
    dataset <- survival::colon
    surv_obj <- survival::Surv(
      time = dataset$time,
      event = dataset$status,
      type = "right"
    )
    d3 <- mlh_subset(surv_obj, c(1:30))
    expect_equal(
      attributes(surv_obj)[names(attributes(surv_obj)) != "dim"],
      attributes(d3)[names(attributes(surv_obj)) != "dim"]
    )

    surv_obj <- survival::Surv(
      time = dataset$time,
      time2 = dataset$time + 20,
      event = dataset$status,
      type = "interval"
    )
    d4 <- mlh_subset(surv_obj, c(1:30))
    expect_equal(
      attributes(surv_obj)[names(attributes(surv_obj)) != "dim"],
      attributes(d4)[names(attributes(surv_obj)) != "dim"]
    )
  }
)

test_that(
  desc = "test mlh - mlh_outsample_row_indices",
  code = {

    set.seed(123)
    class_0 <- rbeta(100, 2, 4)
    class_1 <- (1 - class_0) * 0.4
    class_2 <- (1 - class_0) * 0.6
    dataset <- cbind("0" = class_0, "1" = class_1, "2" = class_2)
    d1 <- mlh_reshape(dataset)
    expect_equal(colnames(dataset), levels(d1))
    expect_length(d1, nrow(dataset))

    colnames(dataset) <- NULL
    d2 <- mlh_reshape(dataset)
    expect_equal(levels(d1), levels(d2))

    class_2 <- (1 - class_0) * 0.8
    dataset <- cbind("0" = class_0, "1" = class_1, "2" = class_2)
    expect_error(mlh_reshape(dataset))

    expect_error(mlh_reshape(dataset[, 1]))
  }
)
