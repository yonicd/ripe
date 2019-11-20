
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

[![Travis-CI Build
Status](https://travis-ci.org/yonicd/ripe.svg?branch=master)](https://travis-ci.org/yonicd/ripe)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/yonicd/ripe?branch=master&svg=true)](https://ci.appveyor.com/project/yonicd/ripe)
[![Covrpage
Summary](https://img.shields.io/badge/covrpage-Last_Build_2019_11_20-brightgreen.svg)](http://tinyurl.com/vzcsnsa)
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
#> [1] 0.04133141 0.17137966 0.82015480 0.23261987 0.26044634
#> 
#> [[2]]
#> [1] 0.62157825 0.09567650 0.04897866 0.66568715 0.48089530
#> 
#> [[3]]
#> [1] 0.5600308 0.9638376 0.8825783 0.3887679 0.6620655
```

## This is better\!

``` r
stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  ripe(replicate,n=4,simplify=FALSE)
#> [[1]]
#> [1] 0.44569696 0.56891227 0.05746438 0.74083185 0.11390839
#> 
#> [[2]]
#> [1] 0.25011961 0.08995676 0.99009074 0.37407570 0.26222560
#> 
#> [[3]]
#> [1] 0.152290092 0.461730018 0.706700897 0.001485429 0.160923742
#> 
#> [[4]]
#> [1] 0.7128270 0.2601389 0.7007489 0.5550923 0.6739421
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
#> [1] 0.6429601 0.9930065 0.1935061 0.7401675 0.9792223
#> 
#> [[2]]
#> [1] 0.6591254 0.4737102 0.4134716 0.9947767 0.3702785
#> 
#> [[3]]
#> [1] 0.1280826 0.9950717 0.4523734 0.6424192 0.8375788
#> 
#> [[4]]
#> [1] 0.4049065 0.6493410 0.9514146 0.6628311 0.7660370
```

## Convert Chain to Lazy

You can also quickly convert the chain to a lazyeval function

``` r
f <- stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  lazy()

f()
#> [1] 0.6418508 0.8929590 0.4753697 0.8075399 0.9526340
f()
#> [1] 0.4713472 0.5042914 0.6246495 0.1494749 0.3800630
```
