
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

[![Travis-CI Build
Status](https://travis-ci.org/yonicd/ripe.svg?branch=master)](https://travis-ci.org/yonicd/ripe)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/yonicd/ripe?branch=master&svg=true)](https://ci.appveyor.com/project/yonicd/ripe)
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
#> [1] 0.4751923 0.5594761 0.5274550 0.8342834 0.5166532
#> 
#> [[2]]
#> [1] 0.9456367 0.6512085 0.7035763 0.9656168 0.3294399
#> 
#> [[3]]
#> [1] 0.6159118 0.6185555 0.5648903 0.8488836 0.7953280
```

## This is better\!

``` r
stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  ripe(replicate,n=4,simplify=FALSE)
#> [[1]]
#> [1] 0.97969972 0.01538066 0.56403107 0.58687205 0.24175846
#> 
#> [[2]]
#> [1] 0.2398980 0.6258530 0.7562197 0.7724702 0.9330338
#> 
#> [[3]]
#> [1] 0.2859123 0.5809636 0.1418302 0.2602835 0.9177566
#> 
#> [[4]]
#> [1] 0.86428137 0.10261961 0.62454881 0.07696361 0.93474347
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
#> [1] 0.78948833 0.77518671 0.50378271 0.33301697 0.06837158
#> 
#> [[2]]
#> [1] 0.89556927 0.32643979 0.13666683 0.04165417 0.79039695
#> 
#> [[3]]
#> [1] 0.09631294 0.80707962 0.32474057 0.39960524 0.39029557
#> 
#> [[4]]
#> [1] 0.5215205 0.1071991 0.1778957 0.1699499 0.9459876
```

## Convert Chain to Lazy

You can also quickly convert the chain to a lazyeval function

``` r
f <- stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  lazy()

f()
#> [1] 0.55897766 0.98781354 0.52183427 0.06937846 0.43971244
f()
#> [1] 0.5921273 0.7996074 0.7356579 0.2170926 0.4816531
```
