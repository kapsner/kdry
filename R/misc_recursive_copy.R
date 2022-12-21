#' @title misc_recursive_copy
#'
#' @description Recursively copying directories and subdirectories.
#'
#' @param source_dir A character string. The path to the directory to be copied.
#' @param target_dir A character string. The target path.
#'
#' @return This function has no return value.

#' @examples
#' \donotrun{
#'   misc_recursive_copy("/tmp/folder", "/tmp/new_folder/")
#' }
#' @export
#'
misc_recursive_copy <- function(source_dir, target_dir) {
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
      misc_recursive_copy(source_dir = fn_old, target_dir = fn_new)
    } else {
      file.copy(from = fn_old, to = fn_new)
    }
  }
}
