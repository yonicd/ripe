
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

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
#> [1] 0.06022373 0.12728522 0.11150625 0.25158204 0.58905788
#> 
#> [[2]]
#> [1] 0.1072398 0.7134321 0.3498681 0.2374182 0.4419980
#> 
#> [[3]]
#> [1] 0.4725874 0.4178627 0.1098458 0.8701580 0.8360550
```

## This is better\!

``` r
stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  ripe(replicate,n=4,simplify=FALSE)
#> [[1]]
#> [1] 0.1156590 0.4126643 0.7622485 0.9492387 0.9783486
#> 
#> [[2]]
#> [1] 0.35866078 0.07050582 0.67521232 0.38224314 0.33469316
#> 
#> [[3]]
#> [1] 0.2419512 0.1423194 0.5818525 0.7163488 0.8450543
#> 
#> [[4]]
#> [1] 0.41080682 0.38536747 0.94532108 0.08396205 0.24204844
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
#> [1] 0.2314191 0.5428888 0.1630212 0.7682106 0.7922107
#> 
#> [[2]]
#> [1] 0.5649696 0.7291185 0.4307413 0.1367933 0.1816979
#> 
#> [[3]]
#> [1] 0.8692706 0.8004550 0.8248950 0.1874990 0.7741495
#> 
#> [[4]]
#> [1] 0.2510581 0.8959941 0.8004985 0.7745013 0.5329853
```

## Convert Chains to Lazy Functions

You can also quickly convert the chain to a lazyeval function

``` r
f <- stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  lazy()

f()
#> [1] 0.2935211 0.2272908 0.6266707 0.8076775 0.5424035
f()
#> [1] 0.76013697 0.79892579 0.46391426 0.09685366 0.41842359
```
