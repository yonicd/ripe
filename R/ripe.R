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
#' @export 
ripe <- function(x,f,...){
  cp <- chain_parts(x)
  
  fname <- deparse(substitute(f))
  
  if(grepl('apply$',fname)){
    
    fapply_ <- function(x){pipe_(cp)}
    
    f(FUN=fapply_,...)
    
  }else{
    
    f_ <- function(){pipe_(cp)}
    
    f(f_(),...)  
    
  }
  
}