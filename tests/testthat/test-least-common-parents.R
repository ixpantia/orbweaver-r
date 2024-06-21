test_that("can find least common parents between selected nodes", {
  graph_edges <- data.frame(
    parent = c("A", "B", "C", "C", "F"),
    child = c("B", "C", "D", "E", "D")
  )

  graph <- graph_builder() |>
    populate_edges(graph_edges, parent, child) |>
    build_directed()

  graph |>
    least_common_parents(c("D", "E")) |>
    as.character() |>
    sort() |>
    expect_equal(c("D", "E"))

  graph |>
    least_common_parents(c("C", "D", "E")) |>
    as.character() |>
    expect_equal("C")

  graph |>
    least_common_parents(c("A", "B", "C", "D", "E", "F")) |>
    as.character() |>
    sort() |>
    expect_equal(c("A", "F"))
})

test_that("can find least common parents between selected nodes on acyclic", {
  graph_edges <- data.frame(
    parent = c("A", "B", "C", "C", "F"),
    child = c("B", "C", "D", "E", "D")
  )

  graph <- graph_builder() |>
    populate_edges(graph_edges, parent, child) |>
    build_acyclic()

  graph |>
    least_common_parents(c("D", "E")) |>
    as.character() |>
    sort() |>
    expect_equal(c("D", "E"))

  graph |>
    least_common_parents(c("C", "D", "E")) |>
    as.character() |>
    expect_equal("C")

  graph |>
    least_common_parents(c("A", "B", "C", "D", "E", "F")) |>
    as.character() |>
    sort() |>
    expect_equal(c("A", "F"))
})
