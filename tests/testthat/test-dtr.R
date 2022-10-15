test_that(
  desc = "test dtr - dtr_matrix2df",
  code = {

    data("iris")
    mat <- data.matrix(iris)
    dataset <- dtr_matrix2df(mat)
    expect_type(dataset, "list")
    expect_type(dataset$Species, "double")
    expect_true(inherits(dataset, c("data.table")))


    dataset <- dtr_matrix2df(mat, cat_vars = "Species")
    expect_true(inherits(dataset$Species, "factor"))

    expect_error(dtr_matrix2df(mat, "car"))
    expect_error(dtr_matrix2df(as.data.frame(mat)))
    expect_error(dtr_matrix2df(mat, c(1, 2)))
  }
)
