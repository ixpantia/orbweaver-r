#' @title Save the graph into a binary blob
#' @param graph A graph object
#' @param path Path to a file to save the graph into
#' @return Run for its side-effects
#' @export
#' @family graphs i/o
#' @examples
#' graph <- graph_builder() |>
#'   add_edge("A", "B") |>
#'   build_directed()
#'
#' graph_to_bin(graph)
graph_to_bin <- function(graph, path) {
  if (missing(path)) {
    return(throw_if_error(graph$to_bin_mem()))
  }
  throw_if_error(graph$to_bin_disk(path))
}

#' @title Read the graph from a binary blob
#' @param path (Optional) Path to a file containing a graph binary
#' @param bin (Optional) The raw binary of the graph
#' @param type The type of graph the JSON represents
#' @return A graph object
#' @export
#' @family graphs i/o
#' @examples
#' bin <- graph_builder() |>
#'   add_edge("A", "B") |>
#'   build_directed() |>
#'   graph_to_bin()
#' bin
#'
#' graph_from_bin(bin = bin)
graph_from_bin <- function(path, bin, type = c("directed", "dag")) {
  if (!type[1] %in% c("directed", "dag")) {
    rlang::abort("Invalid argument `type`")
  }
  if (!missing(bin)) {
    return(
      throw_if_error(
        switch(
          type[1],
          "directed" = DirectedGraph$from_bin_mem(bin),
          "dag" = DirectedAcyclicGraph$from_bin_mem(bin)
        )
      )
    )
  }
  if (missing(path)) {
    rlang::abort("Must provide `path` or `bin` arguments")
  }
  throw_if_error(
    switch(
      type[1],
      "directed" = DirectedGraph$from_bin_disk(path),
      "dag" = DirectedAcyclicGraph$from_bin_disk(path)
    )
  )
}
