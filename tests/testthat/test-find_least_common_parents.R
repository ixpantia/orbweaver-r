test_that("can find least common parents between selected nodes", {
  graph <- data.frame(
    parent = c("A", "B", "C", "C", "F"),
    child = c("B", "C", "D", "E", "D")
  ) |>
    as_graph(type = "acyclic")

  graph |>
    find_least_common_parents(c("D", "E")) |>
    sort() |>
    expect_equal(c("D", "E"))

  graph |>
    find_least_common_parents(c("C", "D", "E")) |>
    expect_equal("C")

  graph |>
    find_least_common_parents(c("A", "B", "C", "D", "E", "F")) |>
    sort() |>
    expect_equal(c("A", "F"))

})
