
<!-- README.md is generated from README.Rmd. Please edit that file -->

# PSAWR <img src="man/figures/logo.png" align="right"/>

<!-- badges: start -->

[![R-CMD-check](https://github.com/schochastics/PSAWR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/schochastics/PSAWR/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/schochastics/PSAWR/branch/main/graph/badge.svg)](https://app.codecov.io/gh/schochastics/PSAWR?branch=main)
[![CRAN
status](https://www.r-pkg.org/badges/version/PSAWR)](https://CRAN.R-project.org/package=PSAWR)
<!-- badges: end -->

`PSAWR` is a **P**ush**s**ift.io **A**PI **W**rapper written in **R**
for comment/submission search for Reddit.

## Installation

You can install the development version of PSAWR like so:

``` r
devtools::install_github("schochastics/PSAWR")
```

## Search comments

Get the last 100 comments mentioning dogs in the subreddit cats.

``` r
search_coments(q = "dogs", subreddit = "cats", size = 100)
```

## Search subreddits

Get the last 10 submissions mentioning cats in the subreddit dogs.

``` r
search_submissions(q="cats", subreddit = "dogs",size = 10)
```
