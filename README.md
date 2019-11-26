
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

[![R build
status](https://github.com/yonicd/ripe/workflows/R/badge.svg)](http://tinyurl.com/vptyaou)
[![Codecov test
coverage](https://codecov.io/gh/yonicd/ripe/branch/master/graph/badge.svg)](https://codecov.io/gh/yonicd/ripe?branch=master)
[![Covrpage
Summary](https://img.shields.io/badge/covrpage-Last_Build_2019_11_20-brightgreen.svg)](http://tinyurl.com/vzcsnsa)
<!-- badges: end -->

# ripe <img src="https://github.com/yonicd/ripe/raw/master/input/logo.png" align="right"  class="logo"/>

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
#> [1] 0.0968035 0.8454892 0.1745602 0.3575017 0.4501556
#> 
#> [[2]]
#> [1] 0.3679469 0.1098656 0.8822747 0.4639327 0.4780120
#> 
#> [[3]]
#> [1] 0.4928808 0.4216918 0.9623356 0.9968997 0.4267262
```

## This is better\!

``` r
stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  ripe(replicate,n=4,simplify=FALSE)
#> [[1]]
#> [1] 0.8804825 0.3483930 0.4533070 0.6211814 0.9554034
#> 
#> [[2]]
#> [1] 0.070709895 0.294193154 0.079700112 0.003996361 0.669914183
#> 
#> [[3]]
#> [1] 0.6945401 0.8577393 0.9127064 0.8887865 0.3525595
#> 
#> [[4]]
#> [1] 0.1899845 0.3562713 0.5428040 0.5239328 0.1734483
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
#> [1] 0.4190696 0.5421558 0.2328920 0.7534823 0.7022927
#> 
#> [[2]]
#> [1] 0.71623630 0.01033047 0.22529627 0.59411469 0.96655041
#> 
#> [[3]]
#> [1] 0.1212441 0.7031401 0.2986797 0.2795129 0.1539391
#> 
#> [[4]]
#> [1] 0.1000496 0.6999692 0.1246881 0.7505028 0.1989340
```

## Convert Chains to Lazy Functions

You can also quickly convert the chain to a lazyeval function

``` r
f <- stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  lazy()

f()
#> [1] 0.9952948 0.9964912 0.7221552 0.5073125 0.6166304
f()
#> [1] 0.84495838 0.62491868 0.47617926 0.57319266 0.09440818
```
