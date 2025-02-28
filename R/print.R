#' @export
print.DirectedGraph <- function(x, ...) {
  writeLines(x$print())
}

#' @export
print.DirectedAcyclicGraph <- function(x, ...) {
  writeLines(x$print())
}
