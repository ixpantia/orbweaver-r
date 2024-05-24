#' @title Serialize the graph into a JSON string
#' @param graph A graph object
#' @param pretty If the JSON string should be prettified
#' @return A JSON string
#' @export
graph_to_json <- function(graph, pretty = FALSE) {
  UseMethod("graph_to_json")
}

#' @export
graph_to_json.DirectedGraph <- function(graph, pretty = FALSE) {
  rs_directed_graph_to_json(graph, pretty)
}

#' @export
graph_to_json.DirectedAcyclicGraph <- function(graph, pretty = FALSE) {
  rs_dag_to_json(graph, pretty)
}

#' @title Get a graph from a JSON string
#' @param text The JSON string to be deserialized
#' @param type The type of graph the JSON represents
#' @return A graph object
#' @export
graph_from_json <- function(text, type = c("directed", "dag")) {
  if (!type %in% c("directed", "dag")) {
    rlang::abort("Invalid argument `type`")
  }
  switch(
    type[1],
    "directed" = rs_directed_graph_from_json(text),
    "dag" = rs_dag_from_json(text)
  )
}
