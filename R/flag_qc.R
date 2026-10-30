#' Flag samples that fail coverage QC
#'
#' @param data A data frame with one row per sample.
#' @param min_depth Minimum mean read depth required to pass.
#' @param min_breadth Minimum fraction of the reference covered (0 to 1).
#' @param depth_col,breadth_col Names of the columns holding depth and breadth.
#' @return `data` with two added columns: `qc_pass` (logical) and
#'          `qc_reason` (character, `NA` when the sample passes).
#' @export
#' @examples
#' samples <- data.frame(
#'   sample = c("S1", "S2", "S3"),
#'   mean_depth = c(45,12,60),
#'   breadth = c(0.98, 0.97, 0.80)
#'   )
#' flag_qc_failures(samples)
flag_qc_failures <- function(data,
                             min_depth = 20,
                             min_breadth = 0.95,
                             depth_col = "mean_depth",
                             breadth_col = "breadth") {
  stopifnot(is.data.frame(data))
  missing_cols <- setdiff(c(depth_col, breadth_col), names(data))
  if (length(missing_cols) > 0) {
    stop("Missing column(s): ", paste(missing_cols, collapse = ", "),
         call. = FALSE)
  }

  depth <- data[[depth_col]]
  breadth <- data[[breadth_col]]

  low_depth <- is.na(depth) | depth < min_depth
  low_breadth <- is.na(breadth) | breadth < min_breadth

  reason <- rep(NA_character_, nrow(data))
  reason[low_depth] <- "low depth"
  reason[low_breadth & !low_depth] <- "low breadth"
  reason[low_breadth & low_depth] <- "low depth; low breadth"

  data$qc_pass <- !(low_depth | low_breadth)
  data$qc_reason <- reason
  data
}
