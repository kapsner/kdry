

# kdry - K’s “Don’t repeat yourself”-collection

<!-- badges: start -->

[![](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![](https://www.r-pkg.org/badges/version/kdry)](https://cran.r-project.org/package=kdry)
[![CRAN
checks](https://badges.cranchecks.info/worst/kdry.svg)](https://cran.r-project.org/web/checks/check_results_kdry.html)
[![](http://cranlogs.r-pkg.org/badges/grand-total/kdry?color=blue)](https://cran.r-project.org/package=kdry)
[![](http://cranlogs.r-pkg.org/badges/last-month/kdry?color=blue)](https://cran.r-project.org/package=kdry)
[![Dependencies](https://tinyverse.netlify.app/badge/kdry)](https://cran.r-project.org/package=kdry)
[![R build
status](https://github.com/kapsner/kdry/workflows/R%20CMD%20Check%20via%20%7Btic%7D/badge.svg)](https://github.com/kapsner/kdry/actions)
[![R build
status](https://github.com/kapsner/kdry/workflows/lint/badge.svg)](https://github.com/kapsner/kdry/actions)
[![R build
status](https://github.com/kapsner/kdry/workflows/test-coverage/badge.svg)](https://github.com/kapsner/kdry/actions)
[![](https://codecov.io/gh/https://github.com/kapsner/kdry/branch/main/graph/badge.svg)](https://codecov.io/gh/https://github.com/kapsner/kdry)
[![](https://img.shields.io/badge/doi-10.32614/CRAN.package.kdry-yellow.svg)](https://doi.org/10.32614/CRAN.package.kdry)

<!-- badges: end -->

This R package provides a collection of helper functions and code
snippets to avoid redundancy in the spirit of the *“Don’t repeat
yourself”* software development principle.

| prefix | description                               |
|--------|-------------------------------------------|
| \-     | No prefix for very basic helper functions |
| dtr\_  | Data transform helper functions           |
| mlh\_  | Machine learning helper functions         |
| pch\_  | Parallel computing helper functions       |
| misc\_ | Miscellaneous functions                   |
| plt\_  | Plots                                     |
| rep\_  | Reporting helper functions                |
| sts\_  | Statistical helper functions              |

## Installation

To install from CRAN:

``` r
install.packages("kdry")
```

You can install the development version of `kdry` with:

``` r
install.packages("remotes")
remotes::install_github("kapsner/kdry")
```
