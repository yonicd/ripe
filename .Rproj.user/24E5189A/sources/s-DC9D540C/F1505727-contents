chain_parts <- function(x){
  
  sc <- sys.calls()
  sc <- sc[- length(sc)]
  sf <- sys.frames()
  
  cp <- get("chain_parts", envir = sys.frame(get_last_pipe_call(sc)))

  idx <- which(sapply(sf,function(x) if(is.environment(x)) length(ls(pattern = 'chain_parts',envir = x))>0))
  
  cp$env <- get('env',envir = sf[[idx]])
  
  cp
}
