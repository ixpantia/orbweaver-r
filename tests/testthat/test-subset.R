test_that("can find subset graph", {
  graph_edges <- data.frame(
    parent = c("A", "B", "C", "C", "F"),
    child = c("B", "C", "D", "E", "D")
  )

  graph <- graph_builder() |>
    populate_edges(graph_edges, "parent", "child") |>
    build_directed()

  graph_under_d <- graph |>
    subset("D")

  expect_equal(as.character(parents(graph_under_d, "D")), character(0))

  graph_under_c <- graph |>
    subset("C")

  expect_equal(as.character(parents(graph_under_d, "C")), character(0))
  expect_equal(as.character(find_path(graph_under_c, "C", "E")), c("C", "E"))

  graph_under_b <- graph |>
    subset("B")

  expect_equal(as.character(find_path(graph_under_b, "B", "E")), c("B", "C", "E"))
  expect_equal(as.character(nodes(graph_under_b)), c("B", "C", "D", "E"))
})

test_that("can find subset acyclic graph", {
  graph_edges <- data.frame(
    parent = c("A", "B", "C", "C", "F"),
    child = c("B", "C", "D", "E", "D")
  )

  graph <- graph_builder() |>
    populate_edges(graph_edges, "parent", "child") |>
    build_acyclic()

  graph_under_d <- graph |>
    subset("D")

  expect_s3_class(graph_under_d, "DirectedAcyclicGraph")
  expect_equal(as.character(parents(graph_under_d, "D")), character(0))

  graph_under_c <- graph |>
    subset("C")

  expect_equal(as.character(parents(graph_under_d, "C")), character(0))
  expect_equal(as.character(find_path(graph_under_c, "C", "E")), c("C", "E"))

  graph_under_b <- graph |>
    subset("B")

  expect_equal(as.character(find_path(graph_under_b, "B", "E")), c("B", "C", "E"))
})

test_that("can find subset graph from multiple nodes (directed)", {
  graph_edges <- data.frame(
    parent = c("A", "B", "C", "C", "F"),
    child  = c("B", "C", "D", "E", "D")
  )

  graph <- graph_builder() |>
    populate_edges(graph_edges, "parent", "child") |>
    build_directed()

  # Subset from two nodes: B and F
  sub_graph <- graph |>
    subset(c("B", "F"))

  # Check that the resulting subgraph includes the
  # reachable descendants from B and F (namely C, D, E) plus B, F themselves.
  # A should not be included since we are not traversing upward.
  expect_equal(sort(as.character(nodes(sub_graph))),
               sort(c("B", "C", "D", "E", "F")))

  # Some path checks:
  # B -> E goes through B -> C -> E
  expect_equal(as.character(find_path(sub_graph, "B", "E")),
               c("B", "C", "E"))
  # F -> D is direct
  expect_equal(as.character(find_path(sub_graph, "F", "D")),
               c("F", "D"))
  # A is not in sub_graph, so the path won't exist
  expect_false("A" %in% as.character(nodes(sub_graph)))
})

test_that("can find subset graph from multiple nodes (acyclic)", {
  graph_edges <- data.frame(
    parent = c("A", "B", "C", "C", "F"),
    child  = c("B", "C", "D", "E", "D")
  )

  graph <- graph_builder() |>
    populate_edges(graph_edges, "parent", "child") |>
    build_acyclic()

  # Subset from two nodes: B and F
  sub_graph <- graph |>
    subset(c("B", "F"))

  # The resulting object should still be a DirectedAcyclicGraph
  expect_s3_class(sub_graph, "DirectedAcyclicGraph")

  # Check that the resulting subgraph includes the
  # reachable descendants from B and F (namely C, D, E) plus B, F themselves.
  expect_equal(sort(as.character(nodes(sub_graph))),
               sort(c("B", "C", "D", "E", "F")))

  # Path checks:
  # B -> E goes through B -> C -> E
  expect_equal(as.character(find_path(sub_graph, "B", "E")),
               c("B", "C", "E"))
  # F -> D is direct
  expect_equal(as.character(find_path(sub_graph, "F", "D")),
               c("F", "D"))
  # A is not included
  expect_false("A" %in% as.character(nodes(sub_graph)))
})

