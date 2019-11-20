
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
#> [1] 0.2899835 0.3854381 0.7996016 0.9581164 0.5743196
#> 
#> [[2]]
#> [1] 0.04143299 0.30903494 0.26686477 0.60786993 0.18395462
#> 
#> [[3]]
#> [1] 0.01608552 0.27588733 0.98949191 0.04866319 0.20950084
```

## This is better\!

``` r
stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  ripe(replicate,n=4,simplify=FALSE)
#> [[1]]
#> [1] 0.77108948 0.42398039 0.05405527 0.03773435 0.96486115
#> 
#> [[2]]
#> [1] 0.8393014 0.8498468 0.2017063 0.7758116 0.5145684
#> 
#> [[3]]
#> [1] 0.9924916 0.8288911 0.8509119 0.5146340 0.3526336
#> 
#> [[4]]
#> [1] 0.02536992 0.59091981 0.63026158 0.06288936 0.59668341
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
#> [1] 0.6297511 0.5408271 0.4699489 0.8571600 0.4581648
#> 
#> [[2]]
#> [1] 0.21542392 0.11758925 0.06380193 0.06736721 0.49799628
#> 
#> [[3]]
#> [1] 0.8884483 0.1521379 0.5420203 0.2293690 0.4243714
#> 
#> [[4]]
#> [1] 0.6242439 0.4581961 0.2375115 0.8792788 0.4866277
```

## Convert Chains to Lazy Functions

You can also quickly convert the chain to a lazyeval function

``` r
f <- stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  lazy()

f()
#> [1] 0.6951200 0.7608402 0.7317298 0.2803652 0.6395113
f()
#> [1] 0.56689311 0.53000450 0.09297894 0.13128130 0.63042343
```
