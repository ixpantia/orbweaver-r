test_that("find all paths on directed graph", {

  graph <- graph_builder() |>
    add_path(c("A", "B", "C")) |>
    add_path(c("A", "Z", "C")) |>
    add_path(c("A", "B", "A")) |>
    build_directed()

  expect_equal(
    find_all_paths(graph, "A", "C"),
    list(c("A", "Z", "C"), c("A", "B", "C"))
  )

})

test_that("find all paths on directed acyclic graph", {

  graph <- graph_builder() |>
    add_path(c("A", "B", "C")) |>
    add_path(c("A", "Z", "C")) |>
    build_acyclic()

  expect_equal(
    find_all_paths(graph, "A", "C"),
    list(c("A", "B", "C"), c("A", "Z", "C"))
  )

})
