
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

[![R build
status](https://github.com/yonicd/ripe/workflows/R-CMD-check/badge.svg)](http://tinyurl.com/skk9m8b)
[![Travis-CI Build
Status](https://travis-ci.org/yonicd/ripe.svg?branch=master)](https://travis-ci.org/yonicd/ripe)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/yonicd/ripe?branch=master&svg=true)](https://ci.appveyor.com/project/yonicd/ripe)
[![Covrpage
Summary](https://img.shields.io/badge/covrpage-Last_Build_2019_11_20-brightgreen.svg)](http://tinyurl.com/vzcsnsa)
[![Codecov test
coverage](https://codecov.io/gh/yonicd/ripe/branch/master/graph/badge.svg)](https://codecov.io/gh/yonicd/ripe?branch=master)
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
#> [1] 0.2317667 0.1222064 0.2630449 0.7754020 0.4002443
#> 
#> [[2]]
#> [1] 0.1768112 0.6522519 0.9192636 0.9669322 0.2738735
#> 
#> [[3]]
#> [1] 0.008380913 0.083472511 0.525649466 0.730356304 0.223921552
```

## This is better\!

``` r
stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  ripe(replicate,n=4,simplify=FALSE)
#> [[1]]
#> [1] 0.04705531 0.74272559 0.02636577 0.16136714 0.35779201
#> 
#> [[2]]
#> [1] 0.59714384 0.02237308 0.87255143 0.60636273 0.99940225
#> 
#> [[3]]
#> [1] 0.3755368 0.8377554 0.5037635 0.9842267 0.7926570
#> 
#> [[4]]
#> [1] 0.72176156 0.84955761 0.67836683 0.62720485 0.02738864
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
#> [1] 0.7484752 0.0659380 0.2341110 0.5354226 0.9545616
#> 
#> [[2]]
#> [1] 0.5708032 0.3733576 0.4422898 0.4108141 0.1941598
#> 
#> [[3]]
#> [1] 0.7147133 0.6300439 0.2011207 0.3689243 0.7010698
#> 
#> [[4]]
#> [1] 0.82576538 0.63758231 0.95799262 0.01546961 0.08182570
```

## Convert Chains to Lazy Functions

You can also quickly convert the chain to a lazyeval function

``` r
f <- stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  lazy()

f()
#> [1] 0.37886551 0.50334015 0.58871377 0.04519280 0.04190966
f()
#> [1] 0.20745522 0.95520404 0.77578514 0.85771197 0.02654204
```
