<!-- README.md is generated from README.Rmd. Please edit that file -->
ripe
====

The goal of ripe is to rerun {magrittr} pipes using a pipe!

Take any {magrittr} chain add `ripe()` and rerun it lazily using your
favorite replication function.

Installation
------------

``` r
remotes::install_github('yonicd/ripe')
```

Example
-------

This is a basic example which shows you how to use `{ripe}`:

### Base `R`

``` r
library(ripe)

stats::runif(20)%>%
  sample(4)%>%
  ripe(replicate,n=4,simplify=FALSE)
#> [[1]]
#> [1] 0.9756952 0.7246193 0.5311547 0.8168651
#> 
#> [[2]]
#> [1] 0.2353462 0.3591452 0.3648200 0.1425354
#> 
#> [[3]]
#> [1] 0.2576865 0.4935596 0.3218738 0.2945429
#> 
#> [[4]]
#> [1] 0.4997085 0.5524490 0.8235440 0.6925399

stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  ripe(replicate,n=4,simplify=FALSE)
#> [[1]]
#> [1] 0.57311114 0.07225216 0.38751683 0.45046922 0.60226963
#> 
#> [[2]]
#> [1] 0.2989451 0.2463726 0.3727520 0.3735351 0.3794158
#> 
#> [[3]]
#> [1] 0.83936493 0.41496790 0.40936185 0.03342964 0.70975895
#> 
#> [[4]]
#> [1] 0.40423570 0.02828346 0.82695483 0.81628388 0.53856995
```

### tidy

``` r
iris %>% 
  dplyr::sample_n(5) %>% 
  ripe(purrr::rerun,.n=3)
#> [[1]]
#>    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#> 13          4.8         3.0          1.4         0.1  setosa
#> 27          5.0         3.4          1.6         0.4  setosa
#> 18          5.1         3.5          1.4         0.3  setosa
#> 40          5.1         3.4          1.5         0.2  setosa
#> 23          4.6         3.6          1.0         0.2  setosa
#> 
#> [[2]]
#>    Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
#> 20          5.1         3.8          1.5         0.3     setosa
#> 62          5.9         3.0          4.2         1.5 versicolor
#> 34          5.5         4.2          1.4         0.2     setosa
#> 76          6.6         3.0          4.4         1.4 versicolor
#> 80          5.7         2.6          3.5         1.0 versicolor
#> 
#> [[3]]
#>    Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
#> 11          5.4         3.7          1.5         0.2     setosa
#> 9           4.4         2.9          1.4         0.2     setosa
#> 89          5.6         3.0          4.1         1.3 versicolor
#> 47          5.1         3.8          1.6         0.2     setosa
#> 94          5.0         2.3          3.3         1.0 versicolor

iris %>% 
  dplyr::select(1:2) %>% 
  dplyr::sample_n(20) %>% 
  ripe(purrr::rerun,.n=3)
#> [[1]]
#>     Sepal.Length Sepal.Width
#> 84           6.0         2.7
#> 140          6.9         3.1
#> 145          6.7         3.3
#> 44           5.0         3.5
#> 57           6.3         3.3
#> 122          5.6         2.8
#> 138          6.4         3.1
#> 72           6.1         2.8
#> 96           5.7         3.0
#> 133          6.4         2.8
#> 2            4.9         3.0
#> 100          5.7         2.8
#> 141          6.7         3.1
#> 66           6.7         3.1
#> 147          6.3         2.5
#> 89           5.6         3.0
#> 22           5.1         3.7
#> 71           5.9         3.2
#> 142          6.9         3.1
#> 52           6.4         3.2
#> 
#> [[2]]
#>     Sepal.Length Sepal.Width
#> 5            5.0         3.6
#> 71           5.9         3.2
#> 2            4.9         3.0
#> 105          6.5         3.0
#> 79           6.0         2.9
#> 106          7.6         3.0
#> 75           6.4         2.9
#> 121          6.9         3.2
#> 83           5.8         2.7
#> 113          6.8         3.0
#> 91           5.5         2.6
#> 117          6.5         3.0
#> 54           5.5         2.3
#> 39           4.4         3.0
#> 26           5.0         3.0
#> 104          6.3         2.9
#> 69           6.2         2.2
#> 51           7.0         3.2
#> 146          6.7         3.0
#> 46           4.8         3.0
#> 
#> [[3]]
#>     Sepal.Length Sepal.Width
#> 7            4.6         3.4
#> 5            5.0         3.6
#> 11           5.4         3.7
#> 43           4.4         3.2
#> 112          6.4         2.7
#> 68           5.8         2.7
#> 62           5.9         3.0
#> 16           5.7         4.4
#> 13           4.8         3.0
#> 127          6.2         2.8
#> 56           5.7         2.8
#> 23           4.6         3.6
#> 116          6.4         3.2
#> 48           4.6         3.2
#> 98           6.2         2.9
#> 131          7.4         2.8
#> 61           5.0         2.0
#> 103          7.1         3.0
#> 18           5.1         3.5
#> 97           5.7         2.9

iris %>% 
  dplyr::select(1:2)%>% 
  dplyr::sample_n(20) %>% 
  dplyr::slice(1:5) %>%
  ripe(purrr::rerun,.n=3)
#> [[1]]
#>   Sepal.Length Sepal.Width
#> 1          5.4         3.4
#> 2          5.5         2.6
#> 3          7.3         2.9
#> 4          4.9         3.6
#> 5          5.7         3.8
#> 
#> [[2]]
#>   Sepal.Length Sepal.Width
#> 1          6.2         2.9
#> 2          5.6         2.5
#> 3          6.4         2.8
#> 4          6.7         3.3
#> 5          4.9         3.1
#> 
#> [[3]]
#>   Sepal.Length Sepal.Width
#> 1          6.1         2.8
#> 2          6.0         3.0
#> 3          5.6         2.7
#> 4          6.0         2.7
#> 5          6.3         3.3
```
