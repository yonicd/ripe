#' @title Replicate magrittr chain
#' @description Lazily replicate magrittr chain
#' @param x chain
#' @param f replication function
#' @param \dots arguments to pass to f
#' @return object that f outputs
#' @examples 
#' stats::runif(20)%>%
#'  sample(4)%>%
#'  ripe(replicate,n=4,simplify=FALSE)
#'  
#' stats::runif(20)%>%
#'  sample(4)%>%
#'  ripe(lapply,X=1:4)
#' @seealso 
#'  \code{\link[purrr]{rerun}}
#' @rdname ripe
#' @family ripe
#' @export 
ripe <- function(x, f, ...){
  
  
  fname <- deparse(substitute(f))

  f_ <- lazy(x)
    
  if(grepl('apply$',fname)){
    
    f(FUN=f_,...)
    
  }else{
    
    f(f_(),...)  
    
  }
  
}

#' @title Convert magrittr chain lazy function
#' @description Input a chain in magrittr syntax and make it a lazyeval function.
#' @param x magrittr chain of functions
#' @return function
#' @examples 
#' f <- stats::runif(20)%>%sample(10)%>%lazy()
#' 
#' f()
#' @rdname lazy
#' @export 
#' @family ripe
lazy <- function(x){
  
  cp <- chain_parts(x)
  
  function(x){pipe_(cp)}
  
}