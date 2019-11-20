Tests and Coverage
================
20 November, 2019 06:26:30

  - [Coverage](#coverage)
  - [Unit Tests](#unit-tests)

This output is created by
[covrpage](https://github.com/metrumresearchgroup/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                                   | Coverage (%) |
| :--------------------------------------- | :----------: |
| ripe                                     |     90.7     |
| [R/pipe.R](../R/pipe.R)                  |     84.0     |
| [R/chain\_parts.R](../R/chain_parts.R)   |    100.0     |
| [R/pipe\_imports.R](../R/pipe_imports.R) |    100.0     |
| [R/ripe.R](../R/ripe.R)                  |    100.0     |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat)
package.

| file                                | n |  time | error | failed | skipped | warning |
| :---------------------------------- | -: | ----: | ----: | -----: | ------: | ------: |
| [test-ripe.R](testthat/test-ripe.R) | 5 | 0.014 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results
</summary>

| file                                    | context             | test                      | status | n |  time |
| :-------------------------------------- | :------------------ | :------------------------ | :----- | -: | ----: |
| [test-ripe.R](testthat/test-ripe.R#L6)  | basic functionality | ripe: rerun once          | PASS   | 1 | 0.005 |
| [test-ripe.R](testthat/test-ripe.R#L10) | basic functionality | ripe: rerun more thanonce | PASS   | 1 | 0.003 |
| [test-ripe.R](testthat/test-ripe.R#L14) | basic functionality | ripe: rerun apply         | PASS   | 1 | 0.004 |
| [test-ripe.R](testthat/test-ripe.R#L26) | basic functionality | lazy: class               | PASS   | 1 | 0.001 |
| [test-ripe.R](testthat/test-ripe.R#L30) | basic functionality | lazy: legnth              | PASS   | 1 | 0.001 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                               |
| :------- | :---------------------------------- |
| Version  | R version 3.6.1 (2019-07-05)        |
| Platform | x86\_64-apple-darwin15.6.0 (64-bit) |
| Running  | macOS Mojave 10.14.5                |
| Language | en\_US                              |
| Timezone | America/New\_York                   |

| Package  | Version |
| :------- | :------ |
| testthat | 2.2.1   |
| covr     | 3.3.0   |
| covrpage | 0.0.70  |

</details>

<!--- Final Status : pass --->
