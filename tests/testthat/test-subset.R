test_that("can find least common parents between selected nodes", {

  graph <- new_directed_graph()

  graph_edges <- data.frame(
    parent = c("A", "B", "C", "C", "F"),
    child = c("B", "C", "D", "E", "D")
  )

  graph_nodes <- data.frame(
    node_id = c("A", "B", "C", "D", "E", "F")
  )

  graph |>
    populate_nodes(graph_nodes, "node_id") |>
    populate_edges(graph_edges, "parent", "child")


  graph_under_d <- graph |>
    subset_graph("D")

  nodes <- graph_under_d |>
    get_nodes()

  expect_equal(length(nodes), 1)

  graph_under_c <- graph |>
    subset_graph("C")

  nodes <- graph_under_c |>
    get_nodes()

  expect_equal(length(nodes), 3)
  expect_equal(find_path(graph_under_c, "C", "E"), c("C", "E"))

  graph_under_b <- graph |>
    subset_graph("B")

  nodes <- graph_under_b |>
    get_nodes()

  expect_equal(length(nodes), 4)
  expect_equal(find_path(graph_under_c, "B", "E"), c("B", "C", "E"))

})
