test_that(
  desc = "test icolnames",
  code = {

    data("iris")
    ret <- icolnames(iris)
    expect_equal(dim(ret), c(5, 2))
  }
)
