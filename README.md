
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
  sample(4)%>%
  ripe(replicate,n=4,simplify=FALSE)
#> [[1]]
#> [1] 0.7870235 0.7446481 0.7913379 0.9929689
#> 
#> [[2]]
#> [1] 0.08621194 0.51112472 0.58687301 0.84720284
#> 
#> [[3]]
#> [1] 0.3501482 0.3812754 0.2167424 0.4290311
#> 
#> [[4]]
#> [1] 0.7009146 0.7082277 0.8960587 0.1962399

stats::runif(20)%>%
  sample(10)%>%
  utils::head(5)%>%
  ripe(replicate,n=4,simplify=FALSE)
#> [[1]]
#> [1] 0.7234500 0.6818897 0.4880786 0.6820515 0.9946336
#> 
#> [[2]]
#> [1] 0.82197491 0.27502449 0.01412892 0.41015420 0.56523385
#> 
#> [[3]]
#> [1] 0.9609404 0.3130023 0.5176005 0.2107718 0.3540407
#> 
#> [[4]]
#> [1] 0.49444785 0.01904007 0.21905688 0.42754079 0.92784164
```

### tidy

``` r
iris %>% 
  dplyr::sample_n(5) %>% 
  ripe(purrr::rerun,.n=3)
#> [[1]]
#>     Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
#> 65           5.6         2.9          3.6         1.3 versicolor
#> 40           5.1         3.4          1.5         0.2     setosa
#> 56           5.7         2.8          4.5         1.3 versicolor
#> 5            5.0         3.6          1.4         0.2     setosa
#> 126          7.2         3.2          6.0         1.8  virginica
#> 
#> [[2]]
#>     Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
#> 141          6.7         3.1          5.6         2.4  virginica
#> 81           5.5         2.4          3.8         1.1 versicolor
#> 143          5.8         2.7          5.1         1.9  virginica
#> 99           5.1         2.5          3.0         1.1 versicolor
#> 34           5.5         4.2          1.4         0.2     setosa
#> 
#> [[3]]
#>     Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
#> 108          7.3         2.9          6.3         1.8  virginica
#> 92           6.1         3.0          4.6         1.4 versicolor
#> 33           5.2         4.1          1.5         0.1     setosa
#> 40           5.1         3.4          1.5         0.2     setosa
#> 32           5.4         3.4          1.5         0.4     setosa

iris %>% 
  dplyr::select(1:2) %>% 
  dplyr::sample_n(20) %>% 
  ripe(purrr::rerun,.n=3)
#> [[1]]
#>     Sepal.Length Sepal.Width
#> 70           5.6         2.5
#> 36           5.0         3.2
#> 6            5.4         3.9
#> 50           5.0         3.3
#> 104          6.3         2.9
#> 119          7.7         2.6
#> 64           6.1         2.9
#> 22           5.1         3.7
#> 53           6.9         3.1
#> 25           4.8         3.4
#> 134          6.3         2.8
#> 135          6.1         2.6
#> 114          5.7         2.5
#> 110          7.2         3.6
#> 60           5.2         2.7
#> 1            5.1         3.5
#> 51           7.0         3.2
#> 80           5.7         2.6
#> 63           6.0         2.2
#> 46           4.8         3.0
#> 
#> [[2]]
#>     Sepal.Length Sepal.Width
#> 49           5.3         3.7
#> 125          6.7         3.3
#> 41           5.0         3.5
#> 117          6.5         3.0
#> 107          4.9         2.5
#> 136          7.7         3.0
#> 2            4.9         3.0
#> 92           6.1         3.0
#> 5            5.0         3.6
#> 103          7.1         3.0
#> 150          5.9         3.0
#> 87           6.7         3.1
#> 36           5.0         3.2
#> 60           5.2         2.7
#> 138          6.4         3.1
#> 39           4.4         3.0
#> 40           5.1         3.4
#> 63           6.0         2.2
#> 45           5.1         3.8
#> 130          7.2         3.0
#> 
#> [[3]]
#>     Sepal.Length Sepal.Width
#> 28           5.2         3.5
#> 66           6.7         3.1
#> 55           6.5         2.8
#> 106          7.6         3.0
#> 91           5.5         2.6
#> 22           5.1         3.7
#> 110          7.2         3.6
#> 127          6.2         2.8
#> 53           6.9         3.1
#> 93           5.8         2.6
#> 46           4.8         3.0
#> 23           4.6         3.6
#> 47           5.1         3.8
#> 48           4.6         3.2
#> 150          5.9         3.0
#> 85           5.4         3.0
#> 31           4.8         3.1
#> 62           5.9         3.0
#> 42           4.5         2.3
#> 34           5.5         4.2

iris %>% 
  dplyr::select(1:2)%>% 
  dplyr::sample_n(20) %>% 
  dplyr::slice(1:5) %>%
  ripe(purrr::rerun,.n=3)
#> [[1]]
#>   Sepal.Length Sepal.Width
#> 1          5.3         3.7
#> 2          5.5         2.4
#> 3          4.6         3.1
#> 4          6.7         2.5
#> 5          4.6         3.2
#> 
#> [[2]]
#>   Sepal.Length Sepal.Width
#> 1          5.1         3.8
#> 2          6.2         3.4
#> 3          6.7         3.0
#> 4          6.2         2.9
#> 5          5.5         2.4
#> 
#> [[3]]
#>   Sepal.Length Sepal.Width
#> 1          5.1         3.8
#> 2          6.0         3.4
#> 3          5.8         4.0
#> 4          5.6         2.9
#> 5          7.7         2.8
```
