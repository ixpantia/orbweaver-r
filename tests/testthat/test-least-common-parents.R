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

  graph |>
    least_common_parents(c("D", "E")) |>
    sort() |>
    expect_equal(c("D", "E"))

  graph |>
    least_common_parents(c("C", "D", "E")) |>
    expect_equal("C")

  graph |>
    least_common_parents(c("A", "B", "C", "D", "E", "F")) |>
    sort() |>
    expect_equal(c("A", "F"))

})
