#' @title misc_recursive_copy
#'
#' @description Recursively copying directories and subdirectories.
#'
#' @param source_dir A character string. The path to the directory to be copied.
#' @param target_dir A character string. The target path.
#' @param force A boolean. If `FALSE` (the default) a dialog is prompted to
#'   ask the user if the directories should be copied recursively. If `TRUE`,
#'   the dialog is not prompted and the `source_dir` is copied directly to
#'   `target_dir`.
#'
#' @return This function has no return value.

#' @examples
#' if (interactive()) {
#'   d1 <- file.path(tempdir(), "folder1")
#'   d2 <- file.path(d1, "folder2")
#'   d3 <- file.path(tempdir(), "new_folder")
#'   f1 <- file.path(d1, "file.one")
#'   dir.create(d2, recursive = TRUE)
#'   file.create(f1)
#'   misc_recursive_copy(d1, d3)
#' }
#' @export
#'
misc_recursive_copy <- function(source_dir, target_dir, force = FALSE) {
  stopifnot("`force` must be a boolean value" = is.logical(force))
  source_dir <- normalizePath(path = source_dir, mustWork = FALSE)
  target_dir <- normalizePath(path = target_dir, mustWork = FALSE)
  if (isFALSE(force)) {
    msg <- paste0(
      "Do you want to recursively copy the directory\n'",
      source_dir, "' to\n'",
      target_dir, "'?"
    )
    answer <- utils::askYesNo(
      msg = message(msg),
      default = NA
    )
    if (!isTRUE(answer)) {
      return(invisible())
    }
  }
  # create output directory
  if (!file.exists(target_dir)) {
    dir.create(target_dir, recursive = TRUE)
  }
  cur_files <- list.files(
    path = source_dir,
    all.files = FALSE,
    full.names = FALSE
  )
  for (f in cur_files) {
    fn_old <- file.path(source_dir, f)
    fn_new <- file.path(target_dir, f)
    fi <- file.info(fn_old)
    if (fi$isdir) {
      dir.create(fn_new, recursive = TRUE)
      misc_recursive_copy(
        source_dir = fn_old,
        target_dir = fn_new,
        force = TRUE
      )
    } else {
      file.copy(from = fn_old, to = fn_new)
    }
  }
}
