test_that("find all paths on directed graph should error", {

  graph <- graph_builder() |>
    add_edge("A", "B") |>
    build_directed()

  expect_error(find_all_paths(graph, "A", "B"))

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
