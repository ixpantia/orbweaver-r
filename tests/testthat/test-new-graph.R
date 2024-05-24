testthat::test_that("new graph", {
  testthat::expect_no_error({
    g <- new_graph() |>
      add_node("a", 1) |>
      add_node("b", 2) |>
      add_node("c", 3)
  })
})

testthat::test_that("get nodes", {
  g <- new_graph() |>
    add_node("a", 1) |>
    add_node("b", 2) |>
    add_node("c", 3)

  nodes <- get_nodes(g, c("a", "b", "c"))
  nodes <- nodes[order(names(nodes))]

  expect_equal(nodes, list("a" = 1, "b" = 2, "c" = 3))
})

testthat::test_that("get all nodes", {
  g <- new_graph() |>
    add_node("a", 1) |>
    add_node("b", 2) |>
    add_node("c", 3)

  nodes <- get_all_nodes(g)
  nodes <- nodes[order(names(nodes))]

  expect_equal(nodes, list("a" = 1, "b" = 2, "c" = 3))
})
