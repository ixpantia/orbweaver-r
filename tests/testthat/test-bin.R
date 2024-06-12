test_that("graph_to_bin in memory directed", {
  graph <- graph_builder() |>
    add_edge("A", "B") |>
    build_directed()

  graph_bin <- graph_to_bin(graph)

  graph_read <- graph_from_bin(bin = graph_bin)

  expect_equal(children(graph, "A"), children(graph_read, "A"))
})

test_that("graph_to_bin in memory acyclic", {
  graph <- graph_builder() |>
    add_edge("A", "B") |>
    build_acyclic()

  graph_bin <- graph_to_bin(graph)

  graph_read <- graph_from_bin(bin = graph_bin, type = "dag")

  expect_equal(children(graph, "A"), children(graph_read, "A"))
})

test_that("graph_from_bin no args should error", {
  expect_error(graph_from_bin())
})

test_that("graph_to_bin on disk directed", {

  temp_file <- tempfile()

  graph <- graph_builder() |>
    add_edge("A", "B") |>
    build_directed()

  graph_to_bin(graph, temp_file)

  graph_read <- graph_from_bin(path = temp_file)

  expect_equal(children(graph, "A"), children(graph_read, "A"))
})

test_that("graph_to_bin on disk acyclic", {

  temp_file <- tempfile()

  graph <- graph_builder() |>
    add_edge("A", "B") |>
    build_acyclic()

  graph_to_bin(graph, temp_file)

  graph_read <- graph_from_bin(path = temp_file, type = "dag")

  expect_equal(children(graph, "A"), children(graph_read, "A"))

})

test_that("graph_from_bin should error on invalid type", {
  graph <- graph_builder() |>
    add_edge("A", "B") |>
    build_directed()

  graph_bin <- graph_to_bin(graph)

  expect_error(graph_from_bin(bin = graph_bin, type = "invalid"))
})
