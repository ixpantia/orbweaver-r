test_that("can get parents", {
  sample_data_frame <- data.frame(
    parent = c("A", "B", "C", "C", "F"),
    child = c("B", "C", "D", "E", "D")
  )

  sample_graph <- as_graph(sample_data_frame, type = "acyclic")

  sample_graph |>
    get_parents("C") |>
    expect_equal("B")

  sample_graph |>
    get_parents("A") |>
    expect_equal(character(0))

  sample_graph |>
    get_parents("D") |>
    sort() |>
    expect_equal(c("C", "F"))

  sample_graph |>
    get_parents("E") |>
    expect_equal("C")
})
