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

  edges <- data.frame(
    Parent = c("A", "A", "B", "C", "D", "Z"),
    Child =  c("B", "C", "Z", "D", "Z", "F")
  )

  graph <- graph_builder() |>
    populate_edges(edges, Parent, Child) |>
    build_acyclic()

  # Find the path from "A" to each child's node
  edges$path_ow <- find_path_one_to_many(graph, "A", edges$Child)
  edges$level <- sapply(edges$path_ow, length)
  edges$path <- sapply(edges$path_ow, \(path) as.character(path))

  # Check that the lengths of each path match our expectations
  expect_equal(
    edges$level,
    c(2, 2, 3, 3, 3, 4)
  )

  # Check the actual paths
  expect_equal(
    edges$path,
    list(
      c("A", "B"),
      c("A", "C"),
      c("A", "B", "Z"),
      c("A", "C", "D"),
      c("A", "B", "Z"),
      c("A", "B", "Z", "F")
    )
  )

})

