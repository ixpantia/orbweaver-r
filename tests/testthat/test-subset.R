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

  expect_equal(parents(graph_under_d, "D"), character(0))

  graph_under_c <- graph |>
    subset("C")

  expect_equal(parents(graph_under_d, "C"), character(0))
  expect_equal(find_path(graph_under_c, "C", "E"), c("C", "E"))

  graph_under_b <- graph |>
    subset("B")

  expect_equal(find_path(graph_under_b, "B", "E"), c("B", "C", "E"))
  expect_equal(nodes(graph_under_b), c("B", "C", "D", "E"))

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
  expect_equal(parents(graph_under_d, "D"), character(0))

  graph_under_c <- graph |>
    subset("C")

  expect_equal(parents(graph_under_d, "C"), character(0))
  expect_equal(find_path(graph_under_c, "C", "E"), c("C", "E"))

  graph_under_b <- graph |>
    subset("B")

  expect_equal(find_path(graph_under_b, "B", "E"), c("B", "C", "E"))

})

test_that("subset shout error with multiple arguments", {

  graph_edges <- data.frame(
    parent = c("A", "B", "C", "C", "F"),
    child = c("B", "C", "D", "E", "D")
  )

  graph <- graph_builder() |>
    populate_edges(graph_edges, "parent", "child") |>
    build_acyclic()

  expect_error({
    graph |>
      subset("A", "B")
  })

  graph <- graph_builder() |>
    populate_edges(graph_edges, "parent", "child") |>
    build_directed()

  expect_error({
    graph |>
      subset("A", "B")
  })

})
