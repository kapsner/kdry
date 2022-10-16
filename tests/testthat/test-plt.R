test_that(
  desc = "test plt - plt_parallel_coordinates",
  code = {

    data("iris")
    p <- plt_parallel_coordinates(data.table::as.data.table(iris[, -5]))
    expect_s3_class(p, "ggplot")
  }
)
