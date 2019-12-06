
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/ripe)](https://CRAN.R-project.org/package=ripe)
[![R-win build
status](https://github.com/yonicd/ripe/workflows/R-win/badge.svg)](https://github.com/yonicd/ripe)
[![R-mac build
status](https://github.com/yonicd/ripe/workflows/R-mac/badge.svg)](https://github.com/yonicd/ripe)
[![R-linux build
status](https://github.com/yonicd/ripe/workflows/R-linux/badge.svg)](https://github.com/yonicd/ripe)
[![Codecov test
coverage](https://codecov.io/gh/yonicd/ripe/branch/master/graph/badge.svg)](https://codecov.io/gh/yonicd/ripe?branch=master)
[![Covrpage
Summary](https://img.shields.io/badge/covrpage-Last_Build_2019_11_20-brightgreen.svg)](http://tinyurl.com/vzcsnsa)
<!-- badges: end -->

# ripe <img src="https://github.com/yonicd/ripe/raw/master/input/logo.png" align="right"  class="logo"/>

The goal of ripe is to create a more flexible way to rerun {magrittr}
pipelines.

## Installation

``` r
remotes::install_github('yonicd/ripe')
```

## Goal

We want to rerun the following pipeline that contains stochastic
elements in a shorter and more flexible way

``` r

f <- function(){
  
  stats::runif(20)%>%
    sample(10)%>%
    utils::head(5)
}

set.seed(123)

replicate(n=3,f(),simplify = FALSE)
#> [[1]]
#> [1] 0.5514350 0.4089769 0.8924190 0.5281055 0.4566147
#> 
#> [[2]]
#> [1] 0.4145463 0.2164079 0.1428000 0.3688455 0.4659625
#> 
#> [[3]]
#> [1] 0.7881958 0.1028646 0.4348927 0.9849570 0.4398317
```

## Can’t I just add replicate to the end of it?

``` r

set.seed(123)

stats::runif(20)%>%
   sample(10)%>%
   utils::head(5)%>%
   replicate(n = 3,simplify = FALSE)
#> [[1]]
#> [1] 0.5514350 0.4089769 0.8924190 0.5281055 0.4566147
#> 
#> [[2]]
#> [1] 0.5514350 0.4089769 0.8924190 0.5281055 0.4566147
#> 
#> [[3]]
#> [1] 0.5514350 0.4089769 0.8924190 0.5281055 0.4566147
```

That didn’t do what we wanted…

## This is better\!

``` r

set.seed(123)

stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  ripe(replicate,n=3,simplify=FALSE)
#> [[1]]
#> [1] 0.4145463 0.2164079 0.1428000 0.3688455 0.4659625
#> 
#> [[2]]
#> [1] 0.7881958 0.1028646 0.4348927 0.9849570 0.4398317
#> 
#> [[3]]
#> [1] 0.9144382 0.4886130 0.7205963 0.4829024 0.6087350
```

## Manipulate Pipeline Replicates

We can now manipulate the pipeline or move `ripe` around into different
subsets of the function sequence, creating iterative replication
workflows.

``` r

set.seed(123)

stats::runif(20)%>%
  #sample(10)%>%
  utils::head(5)%>%
  ripe(replicate,n=3,simplify=FALSE)
#> [[1]]
#> [1] 0.8895393 0.6928034 0.6405068 0.9942698 0.6557058
#> 
#> [[2]]
#> [1] 0.1428000 0.4145463 0.4137243 0.3688455 0.1524447
#> 
#> [[3]]
#> [1] 0.66511519 0.09484066 0.38396964 0.27438364 0.81464004
```

## Convert Pipelines to Lazy Functions

You can also quickly convert the pipelines to a lazyeval function

``` r
f <- stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  lazy()

set.seed(123)

f()
#> [1] 0.5514350 0.4089769 0.8924190 0.5281055 0.4566147

f()
#> [1] 0.4145463 0.2164079 0.1428000 0.3688455 0.4659625
```
