testthat::test_that("can be converted into acyclic", {
  graph <- new_graph() |>
    add_node("a", 1) |>
    add_node("b", 2) |>
    add_node("c", 3) |>
    add_edge("a", "b") |>
    add_edge("b", "c")

  expect_no_error(graph$into_acyclic())

})

testthat::test_that("non acyclic should fail", {
  graph <- new_graph() |>
    add_node("a", 1) |>
    add_node("b", 2) |>
    add_node("c", 3) |>
    add_edge("a", "b") |>
    add_edge("b", "c") |>
    add_edge("c", "a")

  print(graph$into_acyclic())
})
