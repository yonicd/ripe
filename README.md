
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

``` r
library(ripe)

stats::runif(20)%>%
  ripe(replicate,n=2,simplify=FALSE)
#> [[1]]
#>  [1] 0.4483839 0.8592421 0.6199498 0.9242764 0.2885311 0.2627638 0.6293304
#>  [8] 0.6835971 0.4713545 0.1327728 0.6626974 0.4412215 0.1852742 0.6311618
#> [15] 0.9086757 0.2337682 0.3686537 0.2687007 0.1019479 0.6308296
#> 
#> [[2]]
#>  [1] 0.47647380 0.73942738 0.84660488 0.08187619 0.47537117 0.04929327
#>  [7] 0.30082860 0.62861873 0.38462380 0.85635447 0.41678749 0.88756601
#> [13] 0.69142256 0.28013043 0.67728290 0.98391239 0.12084220 0.51665602
#> [19] 0.55006226 0.68341385

stats::runif(20)%>%
  sample(10)%>%
  ripe(replicate,n=3,simplify=FALSE)
#> [[1]]
#>  [1] 0.46104533 0.08464089 0.81806862 0.36922811 0.93148102 0.74737417
#>  [7] 0.16261494 0.33635055 0.80413334 0.92701503
#> 
#> [[2]]
#>  [1] 0.41145724 0.33022792 0.59177099 0.25840542 0.01789453 0.66060239
#>  [7] 0.10514536 0.71509872 0.07899840 0.08410333
#> 
#> [[3]]
#>  [1] 0.89678237 0.97444017 0.48883796 0.86033872 0.07783448 0.97062193
#>  [7] 0.02548059 0.97338517 0.56110652 0.11157133

stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  ripe(replicate,n=4,simplify=FALSE)
#> [[1]]
#> [1] 0.7931393 0.3489260 0.8800525 0.8785827 0.1304712
#> 
#> [[2]]
#> [1] 0.05431186 0.94629886 0.92904128 0.22180830 0.11811913
#> 
#> [[3]]
#> [1] 0.17063481 0.34950257 0.88890505 0.08846811 0.30646916
#> 
#> [[4]]
#> [1] 0.8208981 0.6703363 0.8590293 0.5985634 0.9079847
```

### tidy

``` r
iris %>% 
  dplyr::sample_n(5) %>% 
  ripe(purrr::rerun,.n=3)
#> [[1]]
#>     Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
#> 35           4.9         3.1          1.5         0.2     setosa
#> 124          6.3         2.7          4.9         1.8  virginica
#> 11           5.4         3.7          1.5         0.2     setosa
#> 74           6.1         2.8          4.7         1.2 versicolor
#> 118          7.7         3.8          6.7         2.2  virginica
#> 
#> [[2]]
#>     Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
#> 143          5.8         2.7          5.1         1.9  virginica
#> 115          5.8         2.8          5.1         2.4  virginica
#> 100          5.7         2.8          4.1         1.3 versicolor
#> 112          6.4         2.7          5.3         1.9  virginica
#> 64           6.1         2.9          4.7         1.4 versicolor
#> 
#> [[3]]
#>     Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
#> 61           5.0         2.0          3.5         1.0 versicolor
#> 62           5.9         3.0          4.2         1.5 versicolor
#> 91           5.5         2.6          4.4         1.2 versicolor
#> 119          7.7         2.6          6.9         2.3  virginica
#> 33           5.2         4.1          1.5         0.1     setosa

iris %>% 
  dplyr::select(1:2) %>% 
  dplyr::sample_n(20) %>% 
  ripe(purrr::rerun,.n=1)
#> [[1]]
#>     Sepal.Length Sepal.Width
#> 33           5.2         4.1
#> 94           5.0         2.3
#> 93           5.8         2.6
#> 133          6.4         2.8
#> 120          6.0         2.2
#> 72           6.1         2.8
#> 132          7.9         3.8
#> 127          6.2         2.8
#> 134          6.3         2.8
#> 44           5.0         3.5
#> 58           4.9         2.4
#> 36           5.0         3.2
#> 80           5.7         2.6
#> 124          6.3         2.7
#> 9            4.4         2.9
#> 89           5.6         3.0
#> 3            4.7         3.2
#> 118          7.7         3.8
#> 32           5.4         3.4
#> 81           5.5         2.4

iris %>% 
  dplyr::select(1:2)%>% 
  dplyr::sample_n(20) %>% 
  dplyr::slice(1:5) %>%
  ripe(purrr::rerun,.n=3)
#> [[1]]
#>   Sepal.Length Sepal.Width
#> 1          6.8         3.2
#> 2          5.4         3.4
#> 3          5.7         3.8
#> 4          5.8         4.0
#> 5          5.8         2.6
#> 
#> [[2]]
#>   Sepal.Length Sepal.Width
#> 1          5.2         3.5
#> 2          4.7         3.2
#> 3          5.5         3.5
#> 4          5.6         3.0
#> 5          5.5         2.5
#> 
#> [[3]]
#>   Sepal.Length Sepal.Width
#> 1          4.8         3.1
#> 2          5.1         3.8
#> 3          6.7         3.1
#> 4          4.6         3.4
#> 5          6.7         3.0
```
