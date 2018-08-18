
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Travis-CI Build
Status](https://travis-ci.org/yonicd/ripe.svg?branch=master)](https://travis-ci.org/yonicd/ripe)

# ripe

The goal of ripe is to create a more flexible way to rerun {magrittr}
pipes.

## Installation

``` r
remotes::install_github('yonicd/ripe')
```

## WTAF

We want to write the following in a shorter and more flexible way

``` r

f <- function(){
  
  stats::runif(20)%>%
    sample(10)%>%
    utils::head(5)
}

replicate(n=3,f(),simplify = FALSE)
```

This is better\!

``` r
stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  ripe(replicate,n=4,simplify=FALSE)
```

We can now manipulate the chain or move `ripe` around into different
subsets of the chain, creating iterative replication workflows.

``` r

stats::runif(20)%>%
  #sample(10)%>%
  utils::head(5)%>%
  ripe(replicate,n=4,simplify=FALSE)
  
```

## Examples

<details>

<summary> <code>replicate</code> </summary>

``` r
library(ripe)

stats::runif(20)%>%
  ripe(replicate,n=2,simplify=FALSE)
#> [[1]]
#>  [1] 0.2488058 0.7299046 0.2265629 0.0353546 0.1862956 0.7334467 0.1146018
#>  [8] 0.2439499 0.3050033 0.3128535 0.6699516 0.4613834 0.1935163 0.8586901
#> [15] 0.6185998 0.6263306 0.4028810 0.3521259 0.4290709 0.7859485
#> 
#> [[2]]
#>  [1] 0.69300512 0.91272942 0.14412005 0.90497131 0.01908515 0.32395728
#>  [7] 0.99986583 0.33454564 0.63860198 0.19779360 0.71882874 0.39206187
#> [13] 0.27030830 0.79132496 0.98999292 0.58755129 0.18277716 0.58796680
#> [19] 0.98459229 0.73235191

stats::runif(20)%>%
  sample(10)%>%
  ripe(replicate,n=3,simplify=FALSE)
#> [[1]]
#>  [1] 0.54747818 0.37222390 0.66696106 0.91948326 0.40353155 0.01542922
#>  [7] 0.23866171 0.39581531 0.68976224 0.82761683
#> 
#> [[2]]
#>  [1] 0.31489467 0.82402431 0.36692800 0.67048824 0.17704573 0.56800113
#>  [7] 0.03618267 0.69684086 0.40291484 0.13539082
#> 
#> [[3]]
#>  [1] 0.63622674 0.03086400 0.81327364 0.94641200 0.59537645 0.09872415
#>  [7] 0.17111569 0.54423607 0.72159371 0.01718080

stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  ripe(replicate,n=4,simplify=FALSE)
#> [[1]]
#> [1] 0.72722556 0.05371612 0.10996076 0.26690395 0.25469046
#> 
#> [[2]]
#> [1] 0.05653823 0.50790554 0.42707777 0.04134435 0.61173177
#> 
#> [[3]]
#> [1] 0.2081139 0.4637204 0.9212320 0.8795982 0.5189220
#> 
#> [[4]]
#> [1] 0.6536540 0.6587841 0.1263923 0.6226808 0.9281010
```

</details>

<details>

<summary> <code>apply</code> </summary>

``` r
stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  ripe(lapply, X=1:4)
#> [[1]]
#> [1] 0.2706516 0.0190661 0.0461896 0.4392468 0.3931616
#> 
#> [[2]]
#> [1] 0.94837610 0.23533081 0.23922548 0.76748484 0.05138001
#> 
#> [[3]]
#> [1] 0.7557208 0.3770006 0.2993704 0.4471683 0.6967687
#> 
#> [[4]]
#> [1] 0.56465792 0.48638227 0.95978330 0.98229707 0.05583918
```

</details>

<details>

<summary> <code>mclapply</code> </summary>

``` r
stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  ripe(
    parallel::mclapply,
    X=1:4,
    mc.cores = parallel::detectCores()-1)
#> [[1]]
#> [1] 0.78136195 0.44969050 0.27117744 0.00802389 0.76021746
#> 
#> [[2]]
#> [1] 0.86968522 0.80941066 0.82007655 0.07584982 0.65119560
#> 
#> [[3]]
#> [1] 0.83202549 0.03819145 0.81727947 0.42224246 0.37901987
#> 
#> [[4]]
#> [1] 0.66742842 0.68007540 0.15003728 0.24410910 0.04630343
```

</details>

<details>

<summary> <code>purrr</code> </summary>

``` r
iris %>% 
  dplyr::sample_n(5) %>% 
  ripe(purrr::rerun,.n=3)
#> [[1]]
#>     Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
#> 41           5.0         3.5          1.3         0.3     setosa
#> 130          7.2         3.0          5.8         1.6  virginica
#> 138          6.4         3.1          5.5         1.8  virginica
#> 71           5.9         3.2          4.8         1.8 versicolor
#> 73           6.3         2.5          4.9         1.5 versicolor
#> 
#> [[2]]
#>     Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
#> 46           4.8         3.0          1.4         0.3     setosa
#> 43           4.4         3.2          1.3         0.2     setosa
#> 70           5.6         2.5          3.9         1.1 versicolor
#> 113          6.8         3.0          5.5         2.1  virginica
#> 133          6.4         2.8          5.6         2.2  virginica
#> 
#> [[3]]
#>     Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
#> 132          7.9         3.8          6.4         2.0  virginica
#> 17           5.4         3.9          1.3         0.4     setosa
#> 43           4.4         3.2          1.3         0.2     setosa
#> 24           5.1         3.3          1.7         0.5     setosa
#> 88           6.3         2.3          4.4         1.3 versicolor

iris %>% 
  dplyr::select(1:2) %>% 
  dplyr::sample_n(20) %>% 
  ripe(purrr::rerun,.n=1)
#> [[1]]
#>     Sepal.Length Sepal.Width
#> 22           5.1         3.7
#> 32           5.4         3.4
#> 25           4.8         3.4
#> 10           4.9         3.1
#> 133          6.4         2.8
#> 72           6.1         2.8
#> 51           7.0         3.2
#> 34           5.5         4.2
#> 143          5.8         2.7
#> 63           6.0         2.2
#> 41           5.0         3.5
#> 145          6.7         3.3
#> 136          7.7         3.0
#> 94           5.0         2.3
#> 55           6.5         2.8
#> 139          6.0         3.0
#> 17           5.4         3.9
#> 16           5.7         4.4
#> 148          6.5         3.0
#> 60           5.2         2.7

iris %>% 
  dplyr::select(1:2)%>% 
  dplyr::sample_n(20) %>% 
  dplyr::slice(1:5) %>%
  ripe(purrr::rerun,.n=3)
#> [[1]]
#>   Sepal.Length Sepal.Width
#> 1          5.8         2.8
#> 2          5.0         2.0
#> 3          5.6         3.0
#> 4          6.3         2.8
#> 5          6.9         3.1
#> 
#> [[2]]
#>   Sepal.Length Sepal.Width
#> 1          6.1         3.0
#> 2          6.3         2.9
#> 3          5.1         3.8
#> 4          6.0         2.7
#> 5          4.6         3.4
#> 
#> [[3]]
#>   Sepal.Length Sepal.Width
#> 1          6.7         3.3
#> 2          6.2         2.8
#> 3          5.6         2.5
#> 4          7.7         2.6
#> 5          4.9         2.4
```

</details>

## Convert Chain to Lazy

You can also quickly convert the chain to a lazyeval function

``` r
f <- stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  lazy()

f()
#> [1] 0.7484677 0.6516933 0.3688294 0.1283628 0.1851697
f()
#> [1] 0.95927246 0.56683236 0.78685432 0.08401233 0.09704825
```
