as_data_frame_generic <- function(x) {
  as.data.frame(x$as_data_frame())
}

#' @export
as.data.frame.DirectedGraph <- function(x, ...) {
  as_data_frame_generic(x)
}

#' @export
as.data.frame.DirectedAcyclicGraph <- function(x, ...) {
  as_data_frame_generic(x)
}
