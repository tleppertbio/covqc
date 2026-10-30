# covqc

<!-- badges: start -->
<!-- badges: end -->

covqc flags sequencing samples that fail coverage QC. Given a table of
per-sample coverage summaries, it adds a pass/fail column and a reason for
each failure, based on mean read depth and breadth of coverage.

By default a sample passes when its mean depth is at least 20 and at least
95% of the reference is covered. Both thresholds, and the column names, are
arguments you can change when you call the function. Missing values fail QC.

## Installation

Install the development version from GitHub:

``` r
install.packages("pak")
pak::pkg_install("tleppertbio/covqc")
```

## Example

``` r
library(covqc)

samples <- data.frame(
  sample = c("S1", "S2", "S3"),
  mean_depth = c(45, 12, 60),
  breadth = c(0.98, 0.97, 0.80)
)

flag_qc_failures(samples)
#>   sample mean_depth breadth qc_pass   qc_reason
#> 1     S1         45    0.98    TRUE        <NA>
#> 2     S2         12    0.97   FALSE   low depth
#> 3     S3         60    0.80   FALSE low breadth
```

Use stricter thresholds, or columns with different names:

``` r
flag_qc_failures(samples, min_depth = 30, min_breadth = 0.98)

flag_qc_failures(my_data, depth_col = "meanDepth", breadth_col = "pctCovered")
```

## Arguments

| Argument | Default | Meaning |
|---|---|---|
| `data` | | Data frame with one row per sample |
| `min_depth` | `20` | Minimum mean read depth required to pass |
| `min_breadth` | `0.95` | Minimum fraction of the reference covered (0 to 1) |
| `depth_col` | `"mean_depth"` | Name of the depth column |
| `breadth_col` | `"breadth"` | Name of the breadth column |

The function returns `data` with two added columns: `qc_pass` (logical) and
`qc_reason` (`"low depth"`, `"low breadth"`, `"low depth; low breadth"`, or
`NA` when the sample passes).

## Testing

The package is tested with testthat and passes `devtools::check()`:

``` r
devtools::test()
```
