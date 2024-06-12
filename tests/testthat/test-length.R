test_that("length of directed graph", {
  graph <- graph_builder() |>
    add_path(c("1", "2", "3")) |>
    build_directed()

  expect_equal(length(graph), 3)
})

test_that("length of directed acyclic graph", {
  graph <- graph_builder() |>
    add_path(c("1", "2", "3")) |>
    build_acyclic()

  expect_equal(length(graph), 3)
})

test_that("length of graph builder is always 1", {
  expect_warning(length(graph_builder()))
  suppressWarnings({
    expect_equal(length(graph_builder()), 1)
  })
})
