test_that("can find least common parents between selected nodes", {

  graph_edges <- data.frame(
    parent = c("A", "B", "C", "C", "F"),
    child = c("B", "C", "D", "E", "D")
  )

  graph <- graph_builder() |>
    populate_edges(graph_edges, "parent", "child") |>
    build_directed()

  graph_under_d <- graph |>
    subset("D")

  expect_equal(parents(graph_under_d, "D"), character(0))

  graph_under_c <- graph |>
    subset("C")

  expect_equal(parents(graph_under_d, "C"), character(0))
  expect_equal(find_path(graph_under_c, "C", "E"), c("C", "E"))

  graph_under_b <- graph |>
    subset("B")

  expect_equal(find_path(graph_under_b, "B", "E"), c("B", "C", "E"))

})
