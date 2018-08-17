#' @title FUNCTION_TITLE
#' @description Replicate magrittr chain
#' @param x chain
#' @param f replication function
#' @param \dots arguments to pass to f
#' @return object that f outputs
#' @examples 
#' stats::runif(20)%>%
#'  sample(4)%>%
#'  ripe(replicate,n=4,simplify=FALSE)
#' @seealso 
#'  \code{\link[purrr]{rerun}}
#' @rdname ripe
#' @export 
ripe <- function(x,f,...){
  cp <- chain_parts(x)
  f_ <- function(){pipe_(cp)}

  f(f_(),...)

}
