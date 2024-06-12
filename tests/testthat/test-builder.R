test_that("can initialize a builder", {

  expect_no_error(graph_builder())

})

test_that("can add edge to a builder", {
  expect_no_error({
    graph_builder() |>
      add_edge("Hello", "World")
  })
})

test_that("can add edge to a builder piped", {
  expect_no_error({
    graph_builder() |>
      add_edge("Hello", "World") |>
      add_edge("Hello", "Mundo")
  })
})

test_that("can add path to a builder", {
  expect_no_error({
    graph_builder() |>
      add_path(c("1", "2", "3"))
  })
})

test_that("can add path to a builder piped", {
  expect_no_error({
    graph_builder() |>
      add_path(c("1", "2", "3")) |>
      add_path(c("1", "2", "3", "4"))
  })
})

test_that("can build into a directed graph", {
  graph <- graph_builder() |>
    add_path(c("1", "2", "3", "4")) |>
    build_directed()

  expect_s3_class(graph, "DirectedGraph")
  expect_equal(children(graph, "1"), "2")
  expect_equal(parents(graph, "2"), "1")
})

test_that("can build into a directed acyclic graph", {
  graph <- graph_builder() |>
    add_path(c("1", "2", "3", "4")) |>
    build_acyclic()

  expect_s3_class(graph, "DirectedAcyclicGraph")
  expect_equal(children(graph, "1"), "2")
  expect_equal(parents(graph, "2"), "1")
})

test_that("can populate edges", {
  graph_edges <- data.frame(
    parent = c("A", "B", "C", "C", "F"),
    child = c("B", "C", "D", "E", "D")
  )

  graph <- graph_builder() |>
    populate_edges(graph_edges, "parent", "child") |>
    build_directed()

  expect_s3_class(graph, "DirectedGraph")
  expect_equal(children(graph, "A"), "B")
})

test_that("can populate edges error when not char col1", {
  graph_edges <- data.frame(
    parent = 1:5,
    child = c("B", "C", "D", "E", "D")
  )

  graph <- graph_builder()

  expect_error({
    graph |>
      populate_edges(graph_edges, "parent", "child")
  })

})

test_that("can populate edges error when not char col2", {
  graph_edges <- data.frame(
    child = 1:5,
    parent = c("B", "C", "D", "E", "D")
  )

  graph <- graph_builder()

  expect_error({
    graph |>
      populate_edges(graph_edges, "parent", "child")
  })

})
