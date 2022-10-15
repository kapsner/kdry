test_that(
  desc = "test list.append",
  code = {

    l1 <- list("a" = 1, "b" = 2)
    l2 <- list("c" = 3, "d" = 4)
    la <- list.append(l1, l2)

    expect_type(la, "list")
    expect_length(la, 4)

    lb <- list.append(l1, NULL)
    expect_length(lb, 2)

    lb <- list.append(l1, list())
    expect_length(lb, 2)

    expect_error(list.append(l1, c(1, 2, 3)))
    expect_error(list.append(c(1, 2, 3), l1))

  }
)
