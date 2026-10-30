test_that("passing and failing examples are flagged", {
samples <- data.frame(
  sample = c("S1", "S2", "S3", "S4"),
  mean_depth = c(45, 12, 60, 5),
  breadth = c(0.98, 0.97, 0.80, 0.50)
  )
  result <- flag_qc_failures(samples)
  expect_equal(result$qc_pass, c(TRUE, FALSE, FALSE, FALSE))
  expect_equal(result$qc_reason, c(NA, "low depth", "low breadth", "low depth; low breadth"))
})

test_that("thresholds can be changed", {
  samples <- data.frame(mean_depth = 15, breadth = 0.99)
  expect_false(flag_qc_failures(samples)$qc_pass)
  expect_true(flag_qc_failures(samples,min_depth = 10)$qc_pass)
})

test_that("missing values fail QC", {
  samples <- data.frame(mean_depth = NA, breadth = 0.99)
  expect_false(flag_qc_failures(samples)$qc_pass)
})

test_that("a missing column gives a clear error", {
  expect_error(flag_qc_failures(data.frame(depth = 30)), "Missing column")
})
