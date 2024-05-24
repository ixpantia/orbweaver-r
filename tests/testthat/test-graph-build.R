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
