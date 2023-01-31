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

    lc <- list.append(l1, list(a = 3))
    expect_length(lc, 2)

    ld <- list.append(l1, list(a = NULL), keep.null = FALSE)
    expect_length(ld, 1)

    le <- list.append(l1, list(a = NULL), keep.null = TRUE)
    expect_length(le, 2)

    expect_error(list.append(l1, c(1, 2, 3)))
    expect_error(list.append(c(1, 2, 3), l1))

  }
)

test_that(
  desc = "test list.update",
  code = {

    l1 <- list("a" = 1, "b" = 2)
    l2 <- list("c" = 3, "d" = 4)
    expect_error(list.update(l1, l2))

    l2 <- list(a = 4)
    la <- list.update(l1, l2)

    expect_type(la, "list")
    expect_length(la, 2)

    expect_error(list.update(l1, NULL))

    lb <- list.update(l1, list())
    expect_length(lb, 2)

    expect_error(list.update(l1, list(a = 3, f = 5)))

    ld <- list.update(l1, list(a = NULL), keep.null = FALSE)
    expect_length(ld, 1)

    le <- list.update(l1, list(a = NULL), keep.null = TRUE)
    expect_length(le, 2)

    expect_error(list.update(l1, c(1, 2, 3)))
    expect_error(list.update(c(1, 2, 3), l1))

  }
)
