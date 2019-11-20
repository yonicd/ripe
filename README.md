
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

## In the Tin

We want to write the following in a shorter and more flexible way

``` r

f <- function(){
  
  stats::runif(20)%>%
    sample(10)%>%
    utils::head(5)
}

replicate(n=3,f(),simplify = FALSE)
#> [[1]]
#> [1] 0.2140541 0.7807906 0.1486768 0.9278477 0.5396198
#> 
#> [[2]]
#> [1] 0.1400877 0.1977730 0.4125839 0.4212009 0.5623163
#> 
#> [[3]]
#> [1] 0.6632747 0.5539754 0.9768171 0.5054252 0.9278482
```

This is better\!

``` r
stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  ripe(replicate,n=4,simplify=FALSE)
#> [[1]]
#> [1] 0.4919749 0.7055647 0.3222731 0.9871113 0.5266829
#> 
#> [[2]]
#> [1] 0.4032967 0.2433496 0.7554769 0.3415643 0.9445058
#> 
#> [[3]]
#> [1] 0.02431010 0.97230353 0.07129276 0.43777989 0.96885582
#> 
#> [[4]]
#> [1] 0.36639030 0.99403611 0.20817073 0.83704624 0.05845581
```

We can now manipulate the chain or move `ripe` around into different
subsets of the chain, creating iterative replication workflows.

``` r

stats::runif(20)%>%
  #sample(10)%>%
  utils::head(5)%>%
  ripe(replicate,n=4,simplify=FALSE)
#> [[1]]
#> [1] 0.30592078 0.42349299 0.81517736 0.65845091 0.02478098
#> 
#> [[2]]
#> [1] 0.5649764 0.2977254 0.2345265 0.7947513 0.1465555
#> 
#> [[3]]
#> [1] 0.8273037 0.2019989 0.5789533 0.1287373 0.2093577
#> 
#> [[4]]
#> [1] 0.74336460 0.09282152 0.98527924 0.30607412 0.25233314
```

## Convert Chain to Lazy

You can also quickly convert the chain to a lazyeval function

``` r
f <- stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  lazy()

f()
#> [1] 0.1195843 0.3091965 0.2844328 0.9525715 0.6864801
f()
#> [1] 0.7397019 0.3529096 0.7832813 0.9266863 0.7225231
```
