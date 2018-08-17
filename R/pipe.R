# forked from https://github.com/tidyverse/magrittr
pipe_ <- function(cp){
  
  parent <- parent.frame()
  
  env    <- new.env(parent = parent)
  
  pipes <- cp[["pipes"]] # the pipe operators.
  rhss  <- cp[["rhss" ]] # the right-hand sides.
  lhs   <- cp[["lhs"  ]] # the left-hand side.
  
  # Create the list of functions defined by the right-hand sides.
  env[["_function_list"]] <- 
    lapply(seq_along(rhss), 
           function(i) wrap_function(rhss[[i]], pipes[[i]], parent))
  
  # Create a function which applies each of the above functions in turn.
  env[["_fseq"]] <-
    `class<-`(eval(quote(function(value) freduce(value, `_function_list`)), 
                   env, env), c("fseq", "function"))
  
  # make freduce available to the resulting function 
  # even if magrittr is not loaded.
  env[["freduce"]] <- cp$env$freduce 
  
  # Result depends on the left-hand side.
  if (is_placeholder(lhs)) {
    # return the function itself.
    env[["_fseq"]]
  } else {
    # evaluate the LHS
    env[["_lhs"]] <- eval(lhs, parent, parent)
    
    idx <- length(env$`_function_list`)
    
    env$`_function_list` <- env$`_function_list`[-idx]
    
    if(length(env$`_function_list`)==0)
      env$`_function_list` <-  append(env$`_function_list`,identity)
    
    # compute the result by applying the function to the LHS
    result <- withVisible(eval(expr = quote(`_fseq`(`_lhs`)),envir =  env,enclos =  env))
    
    # If compound assignment pipe operator is used, assign result
    if (is_compound_pipe(pipes[[1L]])) {
      eval(call("<-", lhs, result[["value"]]), parent, parent)
      # Otherwise, return it.
    } else {
      if (result[["visible"]]) 
        result[["value"]] 
      else 
        invisible(result[["value"]])
    }
  }
}