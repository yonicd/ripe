#' @title Replicate magrittr chain
#' @description Lazily replicate magrittr chain
#' @param x chain
#' @param f replication function
#' @param \dots arguments to pass to f
#' @details \code{ripely} is for *apply family of functions.
#' @return object that f outputs
#' @examples 
#' stats::runif(20)%>%
#'  sample(4)%>%
#'  ripe(replicate,n=4,simplify=FALSE)
#'  
#' stats::runif(20)%>%
#'  sample(4)%>%
#'  ripely(lapply,X=1:4)
#' @seealso 
#'  \code{\link[purrr]{rerun}}
#' @rdname ripe
#' @export 
ripe <- function(x,f,...){
  cp <- chain_parts(x)
  f_ <- function(){pipe_(cp)}

  f(f_(),...)

}

#' @rdname ripe
#' @export 
ripely <- function(x,f,...){
  cp <- chain_parts(x)
  f_ <- function(x){pipe_(cp)}
  
  f(FUN=f_,...)
  
}
