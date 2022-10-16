test_that(
  desc = "test sts - sts_normalize",
  code = {

    l1 <- sts_normalize(1:100)
    expect_type(l1, "double")
    expect_length(l1, 100)

    l2 <- sts_normalize(c(1:100, NA, NA, 101:200))
    expect_type(l2, "double")
    expect_length(l2, 202)
    expect_true(all(is.na(l2)))

    l3 <- sts_normalize(c(1:100, NA, NA, 101:200), na.rm = TRUE)
    expect_type(l3, "double")
    expect_length(l3, 200)
    expect_true(!all(is.na(l3)))

    expect_error(sts_normalize(c("a", "b", "c")))
  }
)
