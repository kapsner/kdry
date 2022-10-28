#' @export
mlh_fix_performance_types <- function(FUN, y, perf_args) {
  stopifnot(is.function(FUN), is.list(perf_args),
            all(c("ground_truth", "predictions") %in% names(perf_args)))
  # note that this is very specific to the mlr3measures package
  tryCatch(
    expr = {
      return(do.call(FUN, perf_args))
    }, error = function(e) {
      lvls <- levels(factor(y))
      error <- TRUE
      if (grepl(
        pattern = "Assertion on 'truth' failed: Must be of type 'factor'",
        x = e
      )) {
        # convert to factor
        perf_args$ground_truth <- factor(
          x = perf_args$ground_truth,
          levels = lvls
        )
        error <- FALSE
      } else if (grepl(
        pattern = "Assertion on 'response' failed: Must be of type 'factor'",
        x = e
      )) {
        perf_args$predictions <- factor(
          x = perf_args$predictions,
          levels = lvls
        )
        error <- FALSE
      }

      if (isFALSE(error)) {
        # recursive execution
        args <- list(
          FUN = FUN,
          y = y,
          perf_args = perf_args
        )
        return(do.call(mlh_fix_performance_types, args))
      } else {
        stop(e)
      }
    }
  )
}
