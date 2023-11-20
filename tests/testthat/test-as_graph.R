test_that("can convert from data.frame to acyclic graph", {
  sample_data_frame <- data.frame(
    parent = c("A", "B", "C", "C"),
    child = c("B", "C", "D", "E")
  )

  sample_graph <- as_graph(sample_data_frame, type = "acyclic")

  sample_graph |>
    find_roots() |>
    expect_equal(c("A"))

  sample_graph |>
    find_leaves("A") |>
    sort() |>
    expect_equal(sort(c("D", "E")))
})

test_that("cannot convert from unsupported type to acyclic graph", {
  sample_data_frame <- 1L

  expect_error(as_graph(sample_data_frame, type = "acyclic"))
})
