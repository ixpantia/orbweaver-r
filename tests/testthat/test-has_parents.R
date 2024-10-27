test_that("has_parent on non existing node should error", {
  graph <- graph_builder() |>
    add_path(c("1", "2", "3")) |>
    build_directed()

  expect_equal(has_parents(graph, "3"), TRUE)
  expect_error(has_parents(graph, "4"))
})
