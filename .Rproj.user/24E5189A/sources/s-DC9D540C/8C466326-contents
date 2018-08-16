# internal functions from https://github.com/tidyverse/magrittr

is_pipe <- function(pipe)
{
  identical(pipe, quote(`%>%`))   ||
    identical(pipe, quote(`%T>%`))  ||
    identical(pipe, quote(`%<>%`))  ||
    identical(pipe, quote(`%$%`))
}

is_pipe_call <- function(x) is_pipe(x[[1L]])

is_tee <- function(pipe)
{
  identical(pipe, quote(`%T>%`))
}

is_dollar <- function(pipe)
{
  identical(pipe, quote(`%$%`))
}

is_compound_pipe <- function(pipe)
{
  identical(pipe, quote(`%<>%`))
}

is_placeholder <- function(symbol)
{
  identical(symbol, quote(.))
}

wrap_function <- function(body, pipe, env)
{
  
  if (is_tee(pipe)) {
    body <- call("{", body, quote(.))
  } else if (is_dollar(pipe)) {
    body <- substitute(with(., b), list(b = body))
  } 
  eval(call("function", as.pairlist(alist(.=)), body), env, env)
}
