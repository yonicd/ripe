
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

[![R build
status](https://github.com/yonicd/ripe/workflows/R-CMD-check/badge.svg)](https://github.com/yonicd/ripe/actions?workflow=R-CMD-check)
[![Travis-CI Build
Status](https://travis-ci.org/yonicd/ripe.svg?branch=master)](https://travis-ci.org/yonicd/ripe)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/yonicd/ripe?branch=master&svg=true)](https://ci.appveyor.com/project/yonicd/ripe)
[![Covrpage
Summary](https://img.shields.io/badge/covrpage-Last_Build_2019_11_20-brightgreen.svg)](http://tinyurl.com/vzcsnsa)
<!-- badges: end -->

# ripe <img src="https://github.com/yonicd/ripe/raw/master/input/logo.png" align="right" />

The goal of ripe is to create a more flexible way to rerun {magrittr}
pipes.

## Installation

``` r
remotes::install_github('yonicd/ripe')
```

## Goal

We want to write the following in a shorter and more flexible way

``` r

f <- function(){
  
  stats::runif(20)%>%
    sample(10)%>%
    utils::head(5)
}

replicate(n=3,f(),simplify = FALSE)
#> [[1]]
#> [1] 0.9385146 0.1725202 0.7607894 0.9923666 0.7857740
#> 
#> [[2]]
#> [1] 0.77639772 0.08846635 0.60102090 0.05556567 0.98030365
#> 
#> [[3]]
#> [1] 0.1506858 0.1701349 0.9287769 0.5663497 0.3052817
```

## This is better\!

``` r
stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  ripe(replicate,n=4,simplify=FALSE)
#> [[1]]
#> [1] 0.09174933 0.96802213 0.57355971 0.36670829 0.56757200
#> 
#> [[2]]
#> [1] 0.40509998 0.69974534 0.40848228 0.07479457 0.66618778
#> 
#> [[3]]
#> [1] 0.4654998 0.6028597 0.1133973 0.1914615 0.7297786
#> 
#> [[4]]
#> [1] 0.8504600 0.5852699 0.3479414 0.9839455 0.6046967
```

## Manipulate Chain Replicates

We can now manipulate the chain or move `ripe` around into different
subsets of the chain, creating iterative replication workflows.

``` r

stats::runif(20)%>%
  #sample(10)%>%
  utils::head(5)%>%
  ripe(replicate,n=4,simplify=FALSE)
#> [[1]]
#> [1] 0.37020651 0.14166979 0.06313508 0.12796594 0.01876779
#> 
#> [[2]]
#> [1] 0.86423754 0.07062686 0.95173723 0.90639082 0.62018960
#> 
#> [[3]]
#> [1] 0.06972289 0.36336579 0.03996905 0.26065462 0.07508784
#> 
#> [[4]]
#> [1] 0.08148273 0.33338395 0.87281177 0.55288655 0.39004498
```

## Convert Chains to Lazy Functions

You can also quickly convert the chain to a lazyeval function

``` r
f <- stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  lazy()

f()
#> [1] 0.80581716 0.64729000 0.85928327 0.03125901 0.53460155
f()
#> [1] 0.72824465 0.87676590 0.94123190 0.07881009 0.48061256
```
