test_that(
  desc = "test misc - misc_argument_catcher",
  code = {

    l1 <- misc_argument_catcher(a = 1)
    expect_type(l1, "list")
    expect_length(l1, 1)

    l2 <- misc_argument_catcher(a = 1, b = "car", c = 3)
    expect_type(l2, "list")
    expect_length(l2, 3)

    l3 <- misc_argument_catcher(list(a = 1, b = 2, c = "car"))
    expect_type(l3, "list")
    expect_length(l3, 3)

    l4 <- misc_argument_catcher(list(a = 1, b = 2, c = 3), f = "car")
    expect_type(l4, "list")
    expect_length(l4, 4)

  }
)

test_that(
  desc = "test misc - misc_duplicated_by_names",
  code = {

    l1 <- misc_duplicated_by_names(list(a = 1, b = 2, c = 3))
    expect_type(l1, "logical")
    expect_length(l1, 3)

    l2 <- misc_duplicated_by_names(list(a = 1, b = 2, c = 3, a = 2))
    expect_type(l2, "logical")
    expect_length(l2, 4)
    expect_equal(l2, c(FALSE, FALSE, FALSE, TRUE))

    l2 <- misc_duplicated_by_names(list(a = 1, b = 2, c = 3, a = 2),
                                   fromLast = TRUE)
    expect_type(l2, "logical")
    expect_length(l2, 4)
    expect_equal(l2, c(TRUE, FALSE, FALSE, FALSE))

    l3 <- misc_duplicated_by_names(c(a = 1, b = 2, c = 3, a = 2))
    expect_length(l3, 4)

    expect_error(misc_duplicated_by_names(c(1, 2, 1, 1)))
  }
)


test_that(
  desc = "test misc - misc_subset_options",
  code = {

    l1 <- misc_subset_options("default")
    expect_type(l1, "list")
  }
)


test_that(
  desc = "test misc - misc_subset_options",
  code = {

    d1 <- file.path(tempdir(), "folder1")
    d2 <- file.path(d1, "folder2")
    d3 <- file.path(tempdir(), "new_folder")
    f1 <- file.path(d1, "file.one")
    dir.create(d2, recursive = TRUE)
    file.create(f1)
    expect_silent(
      misc_recursive_copy(d1, d3, force = TRUE)
    )

    # clean up#
    unlink(d1, recursive = TRUE)
    unlink(d3, recursive = TRUE)
  }
)
