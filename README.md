
# covqc

<!-- badges: start -->
<!-- badges: end -->

covqc:
Flag samples that fail coverage QC for sequence quality.
Looks at read depth and breadth of coverage to determine QC.
Current setting min_depth must be greater than 20
Current setting min_breadth must be greater than 0.95
min_depth and min_breadth can be adjusted in flag_qc.R

## Installation

You can install the development version of covqc like so:

``` r

```

## Example

example format:
samples <- data.frame(
  sample = c("S1", "S2", "S3"),
  mean_depth = c(45,12,60),
  breadth = c(0.98, 0.97, 0.80)
  )

example output:
== Results ==========================
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 6 ]

``` r
library(covqc)

## basic example code
- data A data frame with one row per sample.
- min_depth Minimum mean read depth required to pass.
- min_breadth Minimum fraction of the reference covered (0 to 1).
- depth_col,breadth_col Names of the columns holding depth and breadth.
return `data` with two added columns: `qc_pass` (logical) and
       `qc_reason` (character, `NA` when the sample passes).
       

```


