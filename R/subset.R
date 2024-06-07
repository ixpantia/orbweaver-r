#' @export
subset.DirectedGraph <- function(x, node) {
  x$subset(node)
}

#' @export
subset.DirectedAcyclicGraph <- function(x, node) {
  x$subset(node)
}
