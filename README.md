<!-- README.md is generated from README.Rmd. Please edit that file -->
ripe
====

The goal of ripe is to rerun {magrittr} pipes using a pipe!

Take any {magrittr} chain add `ripe()` and rerun it using your favorite
replication function.

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
#> [1] 0.61650073 0.20816403 0.07838699 0.03065529
#> 
#> [[2]]
#> [1] 0.5059499 0.8981735 0.2918089 0.8506055
#> 
#> [[3]]
#> [1] 0.1877883 0.4758776 0.6324516 0.9861050
#> 
#> [[4]]
#> [1] 0.2970767 0.4194110 0.9342086 0.3941149

stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  ripe(replicate,n=4,simplify=FALSE)
#> [[1]]
#> [1] 0.2778779 0.6843873 0.3551182 0.1978106 0.5003351
#> 
#> [[2]]
#> [1] 0.42448516 0.44551887 0.81736132 0.08676625 0.57996583
#> 
#> [[3]]
#> [1] 0.236803383 0.131599961 0.001559015 0.252635174 0.746321016
#> 
#> [[4]]
#> [1] 0.9082943 0.9701550 0.5064918 0.8475597 0.9742287
```

### tidy

``` r
iris %>% 
  dplyr::sample_n(5) %>% 
  ripe(purrr::rerun,.n=3)
#> [[1]]
#>     Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
#> 66           6.7         3.1          4.4         1.4 versicolor
#> 141          6.7         3.1          5.6         2.4  virginica
#> 16           5.7         4.4          1.5         0.4     setosa
#> 20           5.1         3.8          1.5         0.3     setosa
#> 96           5.7         3.0          4.2         1.2 versicolor
#> 
#> [[2]]
#>    Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
#> 90          5.5         2.5          4.0         1.3 versicolor
#> 99          5.1         2.5          3.0         1.1 versicolor
#> 56          5.7         2.8          4.5         1.3 versicolor
#> 48          4.6         3.2          1.4         0.2     setosa
#> 24          5.1         3.3          1.7         0.5     setosa
#> 
#> [[3]]
#>     Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
#> 35           4.9         3.1          1.5         0.2     setosa
#> 111          6.5         3.2          5.1         2.0  virginica
#> 41           5.0         3.5          1.3         0.3     setosa
#> 5            5.0         3.6          1.4         0.2     setosa
#> 90           5.5         2.5          4.0         1.3 versicolor

iris %>% 
  dplyr::select(1:2) %>% 
  dplyr::sample_n(20) %>% 
  ripe(purrr::rerun,.n=3)
#> [[1]]
#>     Sepal.Length Sepal.Width
#> 2            4.9         3.0
#> 108          7.3         2.9
#> 39           4.4         3.0
#> 53           6.9         3.1
#> 110          7.2         3.6
#> 36           5.0         3.2
#> 78           6.7         3.0
#> 138          6.4         3.1
#> 97           5.7         2.9
#> 84           6.0         2.7
#> 31           4.8         3.1
#> 62           5.9         3.0
#> 122          5.6         2.8
#> 74           6.1         2.8
#> 140          6.9         3.1
#> 131          7.4         2.8
#> 75           6.4         2.9
#> 23           4.6         3.6
#> 106          7.6         3.0
#> 116          6.4         3.2
#> 
#> [[2]]
#>     Sepal.Length Sepal.Width
#> 150          5.9         3.0
#> 125          6.7         3.3
#> 10           4.9         3.1
#> 105          6.5         3.0
#> 58           4.9         2.4
#> 126          7.2         3.2
#> 147          6.3         2.5
#> 27           5.0         3.4
#> 128          6.1         3.0
#> 132          7.9         3.8
#> 124          6.3         2.7
#> 90           5.5         2.5
#> 133          6.4         2.8
#> 79           6.0         2.9
#> 1            5.1         3.5
#> 89           5.6         3.0
#> 53           6.9         3.1
#> 98           6.2         2.9
#> 25           4.8         3.4
#> 17           5.4         3.9
#> 
#> [[3]]
#>     Sepal.Length Sepal.Width
#> 31           4.8         3.1
#> 87           6.7         3.1
#> 21           5.4         3.4
#> 4            4.6         3.1
#> 97           5.7         2.9
#> 69           6.2         2.2
#> 111          6.5         3.2
#> 140          6.9         3.1
#> 48           4.6         3.2
#> 19           5.7         3.8
#> 89           5.6         3.0
#> 15           5.8         4.0
#> 35           4.9         3.1
#> 83           5.8         2.7
#> 86           6.0         3.4
#> 44           5.0         3.5
#> 132          7.9         3.8
#> 29           5.2         3.4
#> 131          7.4         2.8
#> 72           6.1         2.8

iris %>% 
  dplyr::select(1:2)%>% 
  dplyr::sample_n(20) %>% 
  dplyr::slice(1:5) %>%
  ripe(purrr::rerun,.n=3)
#> [[1]]
#>   Sepal.Length Sepal.Width
#> 1          5.8         4.0
#> 2          5.9         3.2
#> 3          6.0         3.4
#> 4          5.8         2.6
#> 5          7.9         3.8
#> 
#> [[2]]
#>   Sepal.Length Sepal.Width
#> 1          7.9         3.8
#> 2          4.9         3.1
#> 3          6.3         2.7
#> 4          5.1         3.8
#> 5          7.2         3.2
#> 
#> [[3]]
#>   Sepal.Length Sepal.Width
#> 1          4.8         3.4
#> 2          5.9         3.2
#> 3          7.2         3.2
#> 4          4.4         3.2
#> 5          5.7         3.0
```
