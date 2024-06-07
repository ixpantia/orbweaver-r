#' @export
print.DirectedGraph <- function(x, ...) {
  x$print()
}

#' @export
print.DirectedAcyclicGraph <- function(x, ...) {
  x$print()
}
