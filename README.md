
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
#>  [1] 0.81884231 0.36173371 0.47112509 0.89300833 0.44269232 0.62818352
#>  [7] 0.06389339 0.76393751 0.16694597 0.34838542 0.93476860 0.84951029
#> [13] 0.23559131 0.66581154 0.09288664 0.22833820 0.20051195 0.11887277
#> [19] 0.38078586 0.26395475
#> 
#> [[2]]
#>  [1] 0.496412159 0.815374756 0.500186109 0.926820098 0.432771806
#>  [6] 0.824966070 0.810295709 0.812693314 0.321755813 0.926361102
#> [11] 0.983855040 0.968928646 0.056277975 0.676023050 0.973408849
#> [16] 0.561116818 0.346773865 0.498996172 0.026703685 0.009343755

stats::runif(20)%>%
  sample(10)%>%
  ripe(replicate,n=3,simplify=FALSE)
#> [[1]]
#>  [1] 0.85825507 0.93799444 0.40441327 0.65253852 0.80886448 0.54161475
#>  [7] 0.10667056 0.38658575 0.41392154 0.09859199
#> 
#> [[2]]
#>  [1] 0.05293293 0.76310785 0.71357381 0.17483722 0.96426783 0.91755422
#>  [7] 0.40306486 0.10027459 0.97215523 0.46181990
#> 
#> [[3]]
#>  [1] 0.06134640 0.37395754 0.19691331 0.28482737 0.60865852 0.99772881
#>  [7] 0.56019834 0.02558945 0.92668494 0.11505680

stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  ripe(replicate,n=4,simplify=FALSE)
#> [[1]]
#> [1] 0.594260122 0.002560289 0.729350178 0.743804805 0.167970762
#> 
#> [[2]]
#> [1] 0.2592330 0.4935045 0.4036233 0.7532141 0.5135642
#> 
#> [[3]]
#> [1] 0.56213235 0.66347427 0.19574245 0.04983502 0.70639742
#> 
#> [[4]]
#> [1] 0.1544024 0.3244705 0.3429793 0.9383783 0.3692162
```

#### apply

``` r
stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  ripely(lapply, X=1:4)
#> [[1]]
#> [1] 0.2859437 0.4563628 0.6558749 0.1872755 0.7888899
#> 
#> [[2]]
#> [1] 0.6771308 0.1330576 0.7506357 0.9373103 0.3356323
#> 
#> [[3]]
#> [1] 0.4152398 0.2819624 0.0186496 0.9371968 0.9920431
#> 
#> [[4]]
#> [1] 0.67577226 0.07555466 0.10107644 0.69452565 0.10715615
```

#### mclapply

``` r
stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  ripely(
    parallel::mclapply,
    X=1:4,
    mc.cores = parallel::detectCores()-1)
#> [[1]]
#> [1] 0.9789977 0.1843563 0.8762979 0.5607737 0.5324008
#> 
#> [[2]]
#> [1] 0.2950032 0.5172843 0.5587289 0.9568390 0.1445380
#> 
#> [[3]]
#> [1] 0.5122872 0.9002613 0.7259439 0.9098914 0.2272714
#> 
#> [[4]]
#> [1] 0.8370197 0.9436003 0.1363803 0.6490600 0.7637525
```

### tidy

#### purrr

``` r
iris %>% 
  dplyr::sample_n(5) %>% 
  ripe(purrr::rerun,.n=3)
#> [[1]]
#>     Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
#> 123          7.7         2.8          6.7         2.0  virginica
#> 27           5.0         3.4          1.6         0.4     setosa
#> 104          6.3         2.9          5.6         1.8  virginica
#> 38           4.9         3.6          1.4         0.1     setosa
#> 56           5.7         2.8          4.5         1.3 versicolor
#> 
#> [[2]]
#>     Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
#> 61           5.0         2.0          3.5         1.0 versicolor
#> 105          6.5         3.0          5.8         2.2  virginica
#> 115          5.8         2.8          5.1         2.4  virginica
#> 128          6.1         3.0          4.9         1.8  virginica
#> 84           6.0         2.7          5.1         1.6 versicolor
#> 
#> [[3]]
#>    Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
#> 33          5.2         4.1          1.5         0.1     setosa
#> 47          5.1         3.8          1.6         0.2     setosa
#> 84          6.0         2.7          5.1         1.6 versicolor
#> 4           4.6         3.1          1.5         0.2     setosa
#> 8           5.0         3.4          1.5         0.2     setosa

iris %>% 
  dplyr::select(1:2) %>% 
  dplyr::sample_n(20) %>% 
  ripe(purrr::rerun,.n=1)
#> [[1]]
#>     Sepal.Length Sepal.Width
#> 131          7.4         2.8
#> 140          6.9         3.1
#> 36           5.0         3.2
#> 69           6.2         2.2
#> 1            5.1         3.5
#> 127          6.2         2.8
#> 30           4.7         3.2
#> 31           4.8         3.1
#> 66           6.7         3.1
#> 35           4.9         3.1
#> 124          6.3         2.7
#> 91           5.5         2.6
#> 44           5.0         3.5
#> 141          6.7         3.1
#> 142          6.9         3.1
#> 62           5.9         3.0
#> 15           5.8         4.0
#> 132          7.9         3.8
#> 65           5.6         2.9
#> 105          6.5         3.0

iris %>% 
  dplyr::select(1:2)%>% 
  dplyr::sample_n(20) %>% 
  dplyr::slice(1:5) %>%
  ripe(purrr::rerun,.n=3)
#> [[1]]
#>   Sepal.Length Sepal.Width
#> 1          5.0         3.0
#> 2          5.2         3.5
#> 3          5.7         2.8
#> 4          5.9         3.0
#> 5          5.6         2.9
#> 
#> [[2]]
#>   Sepal.Length Sepal.Width
#> 1          6.4         2.8
#> 2          5.5         3.5
#> 3          5.7         2.8
#> 4          5.0         2.0
#> 5          4.8         3.0
#> 
#> [[3]]
#>   Sepal.Length Sepal.Width
#> 1          5.1         3.8
#> 2          7.7         3.8
#> 3          6.6         2.9
#> 4          5.9         3.0
#> 5          6.0         3.4
```
