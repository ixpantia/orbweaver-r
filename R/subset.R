NO_LIMIT <- -1L

#' @export
subset.DirectedGraph <- function(x, ..., limit = NO_LIMIT) {
  arguments <- c(...)
  if (limit == NO_LIMIT) {
    return(throw_if_error(x$subset_multi(arguments)))
  }
  return(throw_if_error(x$subset_multi_with_limit(arguments, limit)))
}

#' @export
subset.DirectedAcyclicGraph <- function(x, ..., limit = NO_LIMIT) {
  arguments <- c(...)
  if (limit == NO_LIMIT) {
    return(throw_if_error(x$subset_multi(arguments)))
  }
  return(throw_if_error(x$subset_multi_with_limit(arguments, limit)))
}
