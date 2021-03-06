#' @useDynLib tibble, .registration = TRUE
#' @importFrom Rcpp sourceCpp
#' @importFrom utils head tail
#' @import rlang
#' @aliases NULL
#' @details The S3 class `tbl_df` wraps a local data frame. The main
#' advantage to using a `tbl_df` over a regular data frame is the printing:
#' tbl objects only print a few rows and all the columns that fit on one screen,
#' describing the rest of it as text.
#'
#' @section Methods:
#'
#' `tbl_df` implements four important base methods:
#'
#' \describe{
#' \item{print}{By default only prints the first 10 rows (at most 20), and the
#'   columns that fit on screen; see [print.tbl()]}
#' \item{\code{[}}{Never simplifies (drops), so always returns data.frame}
#' \item{\code{[[}, `$`}{Calls [.subset2()] directly,
#'   so is considerably faster. Returns `NULL` if column does not exist,
#'   `$` warns.}
#' }
#' @section Important functions:
#' [tibble()] and [tribble()] for construction,
#' [as_tibble()] for coercion,
#' and [print.tbl()] and [glimpse()] for display.
"_PACKAGE"

#' @name tibble-package
#' @section Package options:
#' Display options for `tbl_df`, used by [trunc_mat()] and
#' (indirectly) by [print.tbl()].
#' \describe{
(op.tibble <- list(
  #' \item{`tibble.print_max`}{Row number threshold: Maximum number of rows
  #'   printed. Set to `Inf` to always print all rows.  Default: 20.}
  tibble.print_max = 20L,

  #' \item{`tibble.print_min`}{Number of rows printed if row number
  #'   threshold is exceeded. Default: 10.}
  tibble.print_min = 10L,

  #' \item{`tibble.width`}{Output width. Default: `NULL` (use
  #'   `width` option).}
  tibble.width = NULL,

  #' \item{`tibble.max_extra_cols`}{Number of extra columns
  #'   printed in reduced form. Default: 100.}
  tibble.max_extra_cols = 100L
  #' }
))

tibble_opt <- function(x) {
  x_tibble <- paste0("tibble.", x)
  res <- getOption(x_tibble)
  if (!is.null(res))
    return(res)

  x_dplyr <- paste0("dplyr.", x)
  res <- getOption(x_dplyr)
  if (!is.null(res))
    return(res)

  op.tibble[[x_tibble]]
}
