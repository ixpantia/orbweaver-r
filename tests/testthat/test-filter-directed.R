testthat::test_that("filter directed", {
  g <- new_graph() |>
    add_node("a", 1) |>
    add_node("b", 2) |>
    add_node("c", 3) |>
    add_edge("a", "b") |>
    add_edge("b", "c")

  greater_than <- function(id, value, x) {
    value > x 
  }

  g <- g |>
    filter_graph(greater_than, x = 1)

  nodes <- get_nodes(g, c("a", "b", "c"))
  nodes <- nodes[order(names(nodes))]

  # We should only have "b" and "c" left
  expect_equal(nodes, list("b" = 2, "c" = 3))

})

testthat::test_that("filter directed with formula", {
  g <- new_graph() |>
    add_node("a", 1) |>
    add_node("b", 2) |>
    add_node("c", 3) |>
    add_edge("a", "b") |>
    add_edge("b", "c")

  g <- g |>
    filter_graph(~ value > 1)

  nodes <- get_nodes(g, c("a", "b", "c"))
  nodes <- nodes[order(names(nodes))]

  # We should only have "b" and "c" left
  expect_equal(nodes, list("b" = 2, "c" = 3))

})
