#' @export
length.DirectedGraph <- function(x) {
  x$n_nodes()
}

#' @export
length.DirectedAcyclicGraph <- function(x) {
  x$n_nodes()
}
