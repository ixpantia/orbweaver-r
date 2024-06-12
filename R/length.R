#' @export
length.DirectedGraph <- function(x) {
  x$length()
}

#' @export
length.DirectedAcyclicGraph <- function(x) {
  x$length()
}

#' @export
length.DirectedGraphBuilder <- function(x) {
  rlang::warn("Length of a graph builder is always 1")
  1
}
