# kdry - K's "Don't repeat yourself"-collection

<!-- badges: start -->
[![CRAN Status Badge](https://www.r-pkg.org/badges/version-ago/kdry)](https://cran.r-project.org/package=kdry)
[![CRAN Checks](https://badges.cranchecks.info/worst/kdry.svg)](https://cran.r-project.org/web/checks/check_results_kdry.html)
[![](http://cranlogs.r-pkg.org/badges/grand-total/kdry?color=blue)](https://cran.r-project.org/package=kdry)
[![](http://cranlogs.r-pkg.org/badges/last-month/kdry?color=blue)](https://cran.r-project.org/package=kdry)
[![Dependencies](https://tinyverse.netlify.com/badge/kdry)](https://cran.r-project.org/package=kdry)
[![](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R build status](https://github.com/kapsner/kdry/workflows/R%20CMD%20Check%20via%20{tic}/badge.svg?branch=main)](https://github.com/kapsner/kdry/actions)
[![R build status](https://github.com/kapsner/kdry/workflows/lint/badge.svg?branch=main)](https://github.com/kapsner/kdry/actions)
[![R build status](https://github.com/kapsner/kdry/workflows/test-coverage/badge.svg?branch=main)](https://github.com/kapsner/kdry/actions)
[![codecov](https://codecov.io/gh/kapsner/kdry/branch/main/graph/badge.svg)](https://app.codecov.io/gh/kapsner/kdry)
<!-- badges: end -->

This R package provides a collection of helper functions and code snippets to avoid redundancy in the spirit of the *"Don't repeat yourself"* software development principle.

| prefix | description |
| ------ | ----------- |
| -      | No prefix for very basic helper functions |
| dtr_   | Data transform helper functions |
| mlh_   | Machine learning helper functions |
| pch_   | Parallel computing helper functions |
| misc_  | Miscellaneous functions |
| plt_   | Plots|
| rep_   | Reporting helper functions |
| sts_   | Statistical helper functions |

## Installation

To install from CRAN:

```{r}
install.packages("kdry")
```

You can install the development version of `kdry` with:

```{r}
install.packages("remotes")
remotes::install_github("kapsner/kdry")
```
