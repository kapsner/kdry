# rep_distribution_meta helper
rep_distribution_meta <- function(central_tendency,
                                  dispersion,
                                  na.rm = TRUE, # nolint
                                  prefix,
                                  suffix,
                                  brackets = c("round", "square")
) {
  stopifnot(
    "`prefix` must be a character" = is.character(prefix)
  )
  brackets <- match.arg(brackets)
  solved_brackets <- switch(brackets, round = c("(", ")"), square = c("[", "]"))

  format_out <- paste0(
    central_tendency, " ",
    solved_brackets[1], prefix, dispersion, suffix, solved_brackets[2]
  )
  return(format_out)
}

# remove digits after decimal point if all zero
remove_all_zero_digits_after_dec <- function(x) { # nolint
  stopifnot("`x` must be a character" = is.character(x))
  # recognize empty digits on right of decimal point
  empty_digit_pattern <- paste0("\\", options("OutDec"), "0+$")
  if (grepl(pattern = empty_digit_pattern, x = x)) {
    x <- gsub(pattern = empty_digit_pattern, replacement = "", x = x)
  }
  return(x)
}
