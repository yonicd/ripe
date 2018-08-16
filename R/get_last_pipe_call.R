# from https://github.com/gaborcsardi/tamper/blob/master/R/dump_pipes.R#L155
get_last_pipe_call <- function(calls) {
  idx <- which(vapply(calls, is_pipe_call, logical(1)))
  res <- idx[length(idx)]
  if (length(res)) res else NA_integer_
}
