# Find the a valid path from one node to many

Find a valid path from one node to many

## Usage

``` r
find_path_one_to_many(graph, from, to)
```

## Arguments

- graph:

  A graph object

- from:

  The starting node of the path

- to:

  A character vector of nodes

## Value

A list of paths

## See also

Other analyze graphs: [`find_all_paths()`](find_all_paths.md),
[`find_path()`](find_path.md), [`get_all_leaves()`](get_all_leaves.md),
[`get_all_roots()`](get_all_roots.md),
[`get_leaves_under()`](get_leaves_under.md),
[`get_roots_over()`](get_roots_over.md),
[`least_common_parents()`](least_common_parents.md)

## Examples

``` r
edges <- data.frame(
  parent = c("A", "A", "B", "Z"),
  child =  c("B", "Z", "Z", "F")
)

graph <- graph_builder() |>
  populate_edges(edges, parent, child) |>
  build_acyclic()

find_path_one_to_many(graph, "A", edges$child)
#> [[1]]
#> # of nodes: 2
#> |           Nodes           |
#> |             A             |
#> |             B             |
#> 
#> 
#> [[2]]
#> # of nodes: 2
#> |           Nodes           |
#> |             A             |
#> |             Z             |
#> 
#> 
#> [[3]]
#> # of nodes: 2
#> |           Nodes           |
#> |             A             |
#> |             Z             |
#> 
#> 
#> [[4]]
#> # of nodes: 3
#> |           Nodes           |
#> |             A             |
#> |             Z             |
#> |             F             |
#> 
#> 
```
