
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
#> [1] 0.62096981 0.05451402 0.19120050 0.34802493 0.06866066
#> 
#> [[2]]
#> [1] 0.7927859 0.9572090 0.2040355 0.3493273 0.1261480
#> 
#> [[3]]
#> [1] 0.17762552 0.21757683 0.83233156 0.32402496 0.04791412
```

## This is better\!

``` r
stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  ripe(replicate,n=4,simplify=FALSE)
#> [[1]]
#> [1] 0.4118553 0.5856254 0.3001437 0.8033649 0.4704976
#> 
#> [[2]]
#> [1] 0.05577871 0.80005485 0.44106425 0.36730765 0.50466705
#> 
#> [[3]]
#> [1] 0.17985130 0.07846578 0.34725173 0.68106126 0.19301542
#> 
#> [[4]]
#> [1] 0.0126675 0.9302062 0.4176194 0.4489732 0.9274800
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
#> [1] 0.1523389 0.3876244 0.9782602 0.2555350 0.4014677
#> 
#> [[2]]
#> [1] 0.3713290 0.3140422 0.2805955 0.1522787 0.1915762
#> 
#> [[3]]
#> [1] 0.51867380 0.07882017 0.27141654 0.16840483 0.69462174
#> 
#> [[4]]
#> [1] 0.9656255 0.8008452 0.9522785 0.1695625 0.6176189
```

## Convert Chains to Lazy Functions

You can also quickly convert the chain to a lazyeval function

``` r
f <- stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  lazy()

f()
#> [1] 0.1735278 0.2112223 0.6750300 0.2673328 0.1007939
f()
#> [1] 0.87296124 0.30220291 0.30185028 0.70023591 0.03549142
```
