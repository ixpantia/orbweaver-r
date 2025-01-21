#' @export
subset.DirectedGraph <- function(x, ...) {
  arguments <- c(...)
  if (length(arguments) > 1) {
    return(throw_if_error(x$subset_multi(arguments)))
  }
  throw_if_error(x$subset(arguments))
}

#' @export
subset.DirectedAcyclicGraph <- function(x, ...) {
  arguments <- c(...)
  if (length(arguments) > 1) {
    return(throw_if_error(x$subset_multi(arguments)))
  }
  throw_if_error(x$subset(arguments))
}
