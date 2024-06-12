test_that("get roots directed", {
  graph <- graph_builder() |>
    add_path(c("A", "B", "C")) |>
    add_path(c("A", "D", "C")) |>
    add_path(c("Z", "B", "C")) |>
    build_directed()


  expect_equal(get_all_roots(graph), c("A", "Z"))
  expect_equal(get_roots_over(graph, "D"), c("A"))
})

test_that("get leaves directed", {
  graph <- graph_builder() |>
    add_path(c("A", "B", "C")) |>
    add_path(c("A", "D", "C")) |>
    add_path(c("Z", "B", "C")) |>
    add_path(c("Z", "B", "H")) |>
    build_directed()

  expect_equal(get_all_leaves(graph), c("C", "H"))
  expect_equal(get_leaves_under(graph, "D"), c("C"))
})

test_that("get roots acyclic", {
  graph <- graph_builder() |>
    add_path(c("A", "B", "C")) |>
    add_path(c("A", "D", "C")) |>
    add_path(c("Z", "B", "C")) |>
    build_acyclic()


  expect_equal(get_all_roots(graph), c("A", "Z"))
  expect_equal(get_roots_over(graph, "D"), c("A"))
})

test_that("get leaves acyclic", {
  graph <- graph_builder() |>
    add_path(c("A", "B", "C")) |>
    add_path(c("A", "D", "C")) |>
    add_path(c("Z", "B", "C")) |>
    add_path(c("Z", "B", "H")) |>
    build_acyclic()

  expect_equal(get_all_leaves(graph), c("C", "H"))
  expect_equal(get_leaves_under(graph, "D"), c("C"))
})
