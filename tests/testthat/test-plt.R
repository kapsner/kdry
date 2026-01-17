test_that(desc = "test plt - plt_parallel_coordinates", code = {
  testthat::skip_if_not_installed("ggplot2")

  data("iris")
  p <- plt_parallel_coordinates(data.table::as.data.table(iris[, -5]))
  expect_s3_class(p, "ggplot")
})
