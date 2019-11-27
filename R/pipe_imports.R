is_pipe          <- get('is_pipe',asNamespace('magrittr'))

is_tee           <- get('is_tee',asNamespace('magrittr'))

is_dollar        <- get('is_dollar',asNamespace('magrittr'))

is_compound_pipe <- get('is_compound_pipe',asNamespace('magrittr'))

is_placeholder   <- get('is_placeholder',asNamespace('magrittr'))

wrap_function    <- get('wrap_function',asNamespace('magrittr'))

# from https://github.com/gaborcsardi/tamper/blob/master/R/dump_pipes.R#L155

get_last_pipe_call <- function(calls) {
  idx <- which(vapply(calls, is_pipe_call, logical(1)))
  res <- idx[length(idx)]
  if (length(res)) res else NA_integer_
}

is_pipe_call <- function(x) is_pipe(x[[1L]])

#' @inherit magrittr::'%>%'
#' @importFrom magrittr %>%
#' @name %>%
#' @rdname pipe
#' @export
NULL
