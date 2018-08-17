
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Travis-CI Build
Status](https://travis-ci.org/yonicd/ripe.svg?branch=master)](https://travis-ci.org/yonicd/ripe)

# ripe

The goal of ripe is to rerun {magrittr} pipes using a pipe\!

Take any {magrittr} chain add `ripe()` and rerun it lazily using your
favorite replication function.

## Installation

``` r
remotes::install_github('yonicd/ripe')
```

## Example

This is a basic example which shows you how to use `{ripe}`:

### Base `R`

#### Replicate

``` r
library(ripe)

stats::runif(20)%>%
  ripe(replicate,n=2,simplify=FALSE)
#> [[1]]
#>  [1] 0.46557454 0.79128782 0.79925780 0.01615841 0.13436933 0.38412121
#>  [7] 0.81203683 0.44263841 0.40722944 0.89488197 0.61502011 0.73726950
#> [13] 0.85138644 0.98024640 0.62476610 0.38439674 0.20016181 0.96919089
#> [19] 0.25957437 0.61561896
#> 
#> [[2]]
#>  [1] 0.45699385 0.11411597 0.96335278 0.13287712 0.66782420 0.03086701
#>  [7] 0.02190010 0.88097636 0.92347899 0.92723267 0.53305559 0.39737624
#> [13] 0.89784080 0.90805160 0.90005491 0.13515345 0.52159340 0.95461584
#> [19] 0.75463015 0.98160621

stats::runif(20)%>%
  sample(10)%>%
  ripe(replicate,n=3,simplify=FALSE)
#> [[1]]
#>  [1] 0.34314921 0.51216670 0.36209948 0.65665015 0.24274934 0.48749977
#>  [7] 0.40120609 0.02065031 0.88095260 0.95817386
#> 
#> [[2]]
#>  [1] 0.1096811 0.9676339 0.9406004 0.4686866 0.2404807 0.3478017 0.7007679
#>  [8] 0.9510402 0.2334638 0.5691419
#> 
#> [[3]]
#>  [1] 0.534608202 0.560345647 0.007578015 0.016090199 0.306497617
#>  [6] 0.247422804 0.311898705 0.929054685 0.230498259 0.375675153

stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  ripe(replicate,n=4,simplify=FALSE)
#> [[1]]
#> [1] 0.34460255 0.62876305 0.46237381 0.67134119 0.05331481
#> 
#> [[2]]
#> [1] 0.7862914 0.6009496 0.2969631 0.7975500 0.3673830
#> 
#> [[3]]
#> [1] 0.4118641 0.6434575 0.6648004 0.2623868 0.7110280
#> 
#> [[4]]
#> [1] 0.2323375 0.3408813 0.2191213 0.2915875 0.1436112
```

#### apply

``` r
stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  ripe(lapply, X=1:4)
#> [[1]]
#> [1] 0.75155898 0.29784928 0.40173123 0.42047568 0.01146672
#> 
#> [[2]]
#> [1] 0.54030323 0.27682496 0.05225742 0.41455840 0.14124286
#> 
#> [[3]]
#> [1] 0.3118874 0.8395095 0.1605646 0.6194434 0.0542227
#> 
#> [[4]]
#> [1] 0.2760866 0.1380978 0.6052450 0.1739862 0.7066905
```

#### mclapply

``` r
stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  ripe(
    parallel::mclapply,
    X=1:4,
    mc.cores = parallel::detectCores()-1)
#> [[1]]
#> [1] 0.5573351 0.9946402 0.4269635 0.4795345 0.4001646
#> 
#> [[2]]
#> [1] 0.56933696 0.91550095 0.05408525 0.54675279 0.62702772
#> 
#> [[3]]
#> [1] 0.5487330 0.6928211 0.2168340 0.8690808 0.6050135
#> 
#> [[4]]
#> [1] 0.4343659 0.2027149 0.1129372 0.6087531 0.6400397
```

### tidy

#### purrr

``` r
iris %>% 
  dplyr::sample_n(5) %>% 
  ripe(purrr::rerun,.n=3)
#> [[1]]
#>     Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
#> 69           6.2         2.2          4.5         1.5 versicolor
#> 99           5.1         2.5          3.0         1.1 versicolor
#> 138          6.4         3.1          5.5         1.8  virginica
#> 8            5.0         3.4          1.5         0.2     setosa
#> 11           5.4         3.7          1.5         0.2     setosa
#> 
#> [[2]]
#>    Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
#> 90          5.5         2.5          4.0         1.3 versicolor
#> 21          5.4         3.4          1.7         0.2     setosa
#> 55          6.5         2.8          4.6         1.5 versicolor
#> 52          6.4         3.2          4.5         1.5 versicolor
#> 35          4.9         3.1          1.5         0.2     setosa
#> 
#> [[3]]
#>     Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
#> 75           6.4         2.9          4.3         1.3 versicolor
#> 134          6.3         2.8          5.1         1.5  virginica
#> 110          7.2         3.6          6.1         2.5  virginica
#> 90           5.5         2.5          4.0         1.3 versicolor
#> 85           5.4         3.0          4.5         1.5 versicolor

iris %>% 
  dplyr::select(1:2) %>% 
  dplyr::sample_n(20) %>% 
  ripe(purrr::rerun,.n=1)
#> [[1]]
#>     Sepal.Length Sepal.Width
#> 28           5.2         3.5
#> 46           4.8         3.0
#> 93           5.8         2.6
#> 88           6.3         2.3
#> 62           5.9         3.0
#> 60           5.2         2.7
#> 42           4.5         2.3
#> 131          7.4         2.8
#> 124          6.3         2.7
#> 5            5.0         3.6
#> 50           5.0         3.3
#> 135          6.1         2.6
#> 33           5.2         4.1
#> 85           5.4         3.0
#> 26           5.0         3.0
#> 4            4.6         3.1
#> 31           4.8         3.1
#> 81           5.5         2.4
#> 70           5.6         2.5
#> 84           6.0         2.7

iris %>% 
  dplyr::select(1:2)%>% 
  dplyr::sample_n(20) %>% 
  dplyr::slice(1:5) %>%
  ripe(purrr::rerun,.n=3)
#> [[1]]
#>   Sepal.Length Sepal.Width
#> 1          6.5         3.0
#> 2          5.5         4.2
#> 3          6.3         2.3
#> 4          6.3         2.5
#> 5          5.7         2.9
#> 
#> [[2]]
#>   Sepal.Length Sepal.Width
#> 1          5.8         2.7
#> 2          5.0         3.4
#> 3          5.8         2.7
#> 4          5.5         2.4
#> 5          5.9         3.0
#> 
#> [[3]]
#>   Sepal.Length Sepal.Width
#> 1          5.7         2.5
#> 2          6.3         2.8
#> 3          6.7         3.3
#> 4          4.9         3.1
#> 5          5.1         3.5
```
