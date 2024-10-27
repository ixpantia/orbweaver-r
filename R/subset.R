#' @export
subset.DirectedGraph <- function(x, ...) {
  arguments <- c(...)
  if (length(arguments) > 1) {
    rlang::abort("Currently only one node is supported for subset")
  }
  throw_if_error(x$subset(arguments))
}

#' @export
subset.DirectedAcyclicGraph <- function(x, ...) {
  arguments <- c(...)
  if (length(arguments) > 1) {
    rlang::abort("Currently only one node is supported for subset")
  }
  throw_if_error(x$subset(arguments))
}
