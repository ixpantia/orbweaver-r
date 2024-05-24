test_that("a new directed graph can be initialized", {
  expect_no_error({
    new_directed_graph()
  })
})

test_that("add a node to a directed graph", {
  expect_no_error({
    new_directed_graph() |>
      add_node("A", "Hello World")
  })
})

test_that("add and retrieve node in a directed graph", {
  graph <- new_directed_graph() |>
    add_node("A", "Hello World")

  node_data <- graph |>
    get_node("A") |>
    get_node_data()

  expect_equal(node_data, "Hello World")
})

test_that("add a edge to a directed graph", {
  graph <- new_directed_graph() |>
    add_node("A", "Hello World") |>
    add_node("B", "John Doe") |>
    add_edge("A", "B")

  expect_equal(edge_exists(graph, "A", "B"), TRUE)
})

test_that("populate data and edges from data.frame", {
  graph <- new_directed_graph()

  graph_edges <- tibble::tibble(
    parent = c("A", "B", "C", "C", "F"),
    child = c("B", "C", "D", "E", "D")
  )

  graph_nodes <- tibble::tibble(
    node_id = c("A", "B", "C", "D", "E", "F"),
    data = c(1:6)
  )

  graph |>
    populate_nodes(graph_nodes, "node_id", "data") |>
    populate_edges(graph_edges, "parent", "child")

  graph |>
    get_node("C") |>
    get_node_data() |>
    expect_equal(3)

})

test_that("populate data and edges from tibble with list column", {
  graph <- new_directed_graph()

  graph_edges <- tibble::tibble(
    parent = c("A", "B", "C", "C", "F"),
    child = c("B", "C", "D", "E", "D")
  )

  graph_nodes <- tibble::tibble(
    node_id = c("A", "B", "C", "D", "E", "F"),
    data = lapply(1:6, \(x) letters)
  )

  graph |>
    populate_nodes(graph_nodes, "node_id", "data") |>
    populate_edges(graph_edges, "parent", "child")

  graph |>
    get_node("C") |>
    get_node_data() |>
    expect_equal(letters)

})

