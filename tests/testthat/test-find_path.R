test_that("find all paths on directed graph", {
  graph <- graph_builder() |>
    add_path(c("A", "B", "C")) |>
    add_path(c("A", "Z", "C")) |>
    add_path(c("A", "B", "A")) |>
    build_directed()

  expect_equal(
    find_all_paths(graph, "A", "C") |> lapply(as.character),
    list(c("A", "B", "C"), c("A", "Z", "C"))
  )
})

test_that("find all paths on directed acyclic graph", {
  graph <- graph_builder() |>
    add_path(c("A", "B", "C")) |>
    add_path(c("A", "Z", "C")) |>
    build_acyclic()

  expect_equal(
    find_all_paths(graph, "A", "C") |> lapply(as.character),
    list(c("A", "Z", "C"), c("A", "B", "C"))
  )
})

test_that("find path from one node to many nodes", {

  edges <- tibble::tibble(
    Parent = c("A", "A", "B", "C", "D", "Z"),
    Child = c("B", "C", "Z", "D", "Z", "F")
  )

  graph <- graph_builder() |>
    populate_edges(edges, Parent, Child) |>
    build_acyclic()

  edges$path_ow <- find_path_one_to_many(graph, "A", edges$Child)
  edges$level <- sapply(edges$path_ow, length)
  edges$path <- sapply(edges$path_ow, \(path) paste(as.character(path), collapse = "|"))

  expect_equal(
    edges$level,
    c(2, 2, 5, 3, 5, 6)
  )

  expect_equal(
    edges$path,
    c(
      "A|B",
      "A|C",
      "A|B|C|D|Z",
      "A|C|D",
      "A|B|C|D|Z",
      "A|B|C|D|Z|F"
    )
  )

})
