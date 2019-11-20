
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

[![Travis-CI Build
Status](https://travis-ci.org/yonicd/ripe.svg?branch=master)](https://travis-ci.org/yonicd/ripe)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/yonicd/ripe?branch=master&svg=true)](https://ci.appveyor.com/project/yonicd/ripe)
[![Covrpage
Summary](covrpage-Last_Build_2019_11_20-brightgreen.svg)](http://tinyurl.com/vzcsnsa)
<!-- badges: end -->

# ripe

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
#> [1] 0.7007931 0.8270890 0.2319819 0.6476640 0.4718875
#> 
#> [[2]]
#> [1] 0.39698407 0.54434698 0.05831948 0.03938388 0.82409276
#> 
#> [[3]]
#> [1] 0.4740344 0.2780477 0.4772075 0.6111966 0.7993007
```

## This is better\!

``` r
stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  ripe(replicate,n=4,simplify=FALSE)
#> [[1]]
#> [1] 0.3280992 0.9755997 0.4630788 0.3417383 0.7335484
#> 
#> [[2]]
#> [1] 0.4337700 0.5945014 0.5154666 0.6110755 0.2563256
#> 
#> [[3]]
#> [1] 0.00741089 0.76272490 0.38387502 0.79113103 0.93745556
#> 
#> [[4]]
#> [1] 0.5254051 0.4799984 0.3597678 0.5442750 0.1054646
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
#> [1] 0.88427737 0.03443941 0.41760083 0.02225060 0.21407943
#> 
#> [[2]]
#> [1] 0.3901295 0.9204405 0.1552977 0.1178061 0.1973348
#> 
#> [[3]]
#> [1] 0.04120516 0.15025562 0.98000486 0.35402538 0.84813806
#> 
#> [[4]]
#> [1] 0.6118101 0.3585138 0.7631173 0.6883277 0.3629025
```

## Convert Chain to Lazy

You can also quickly convert the chain to a lazyeval function

``` r
f <- stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  lazy()

f()
#> [1] 0.6323848 0.3859844 0.3235282 0.4981219 0.6913391
f()
#> [1] 0.8104247 0.4129851 0.2644532 0.6501891 0.7640080
```
