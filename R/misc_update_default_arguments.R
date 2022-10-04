#' @export
misc_update_default_arguments <- function(new, default) {
  stopifnot(
    is.list(new), is.list(default),
    identical(intersect(names(new), names(default)), names(new))
  )

  updated <- sapply(
    X = names(default),
    FUN = function(x) {
      if (x %in% names(new)) {
        ifelse(
          test = new[[x]] != default[[x]],
          yes = new[[x]],
          no = default[[x]]
        )
      } else {
        default[[x]]
      }
    }
  )
  return(updated)
}
