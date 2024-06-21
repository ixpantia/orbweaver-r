test_that("can find least common parents between selected nodes", {
  graph <- graph_builder() |>
    add_path(c("A", "B", "C")) |>
    build_directed()

  expect_equal(
    as.character(find_path(graph, "A", "C")),
    c("A", "B", "C")
  )
})
