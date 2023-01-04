local_edition(3)

test_that(
  desc = "test rep - rep_mean_sd",
  code = {

    set.seed(123)
    x <- rnorm(1000)
    wt <- rbeta(1000, shape1 = 2, shape2 = 3)
    expect_snapshot_output(rep_mean_sd(x))
    expect_snapshot_output(rep_mean_sd(rep(1, 10)))
    expect_snapshot_output(rep_mean_sd(x, sd_brackets = "square"))
    expect_snapshot_output(
      rep_mean_sd(x, sd_brackets = "square", sd_prefix = FALSE)
    )
    expect_snapshot_output(
      rep_mean_sd(x, weighted = TRUE, weights = wt)
    )
  }
)

test_that(
  desc = "test rep - rep_median_ci",
  code = {

    set.seed(123)
    x <- rnorm(1000)
    wt <- rbeta(1000, shape1 = 2, shape2 = 3)
    expect_snapshot_output(rep_median_ci(x, conf_int = 95))
    expect_snapshot_output(rep_median_ci(rep(1, 10), conf_int = 95))
    expect_snapshot_output(rep_median_ci(x, conf_int = 95, collapse = "-"))
    expect_snapshot_output(
      rep_median_ci(x, iqr_brackets = "square",
                    conf_int = 50, iqr_prefix = FALSE)
    )
    expect_snapshot_output(
      rep_median_ci(x, conf_int = 95, weighted = TRUE, weights = wt)
    )
  }
)

test_that(
  desc = "test rep - rep_median_iqr",
  code = {

    set.seed(123)
    x <- rnorm(1000)
    wt <- rbeta(1000, shape1 = 2, shape2 = 3)
    expect_snapshot_output(rep_median_iqr(x))
    expect_snapshot_output(rep_median_iqr(rep(1, 10)))
    expect_snapshot_output(rep_median_iqr(x, collapse = "-"))
    expect_snapshot_output(
      rep_median_iqr(x, iqr_brackets = "square", iqr_prefix = FALSE)
    )
    expect_snapshot_output(
      rep_median_iqr(x, iqr_brackets = "square")
    )
  }
)

test_that(
  desc = "test rep - rep_sum_pct",
  code = {

    expect_snapshot_output(rep_sum_pct(count = 40, count_reference = 200))
    expect_snapshot_output(
      rep_sum_pct(count = 40, count_reference = 200, brackets = "square")
    )
    expect_snapshot_output(
      rep_sum_pct(40, 200, brackets = "square", suffix = FALSE)
    )
  }
)
