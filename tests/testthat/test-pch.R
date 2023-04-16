test_that(
  desc = "test pch - pch_check_available_cores",
  code = {

    expect_type(
      pch_check_available_cores(2),
      "integer"
    )
  }
)

test_that(
  desc = "test pch - pch_clean_up, pch_register_parallel",
  code = {

    cl <- pch_register_parallel(pch_check_available_cores(ncores = 2))
    expect_true(inherits(cl, c("SOCKcluster", "cluster")))
    expect_silent(pch_clean_up(cl))
  }
)
