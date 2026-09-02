# Find all paths between two nodes

Find all the paths between two nodes in a graph.

Not all graphs support this function. Currently only
`DirectedAcyclicGraph` supports this.

## Usage

``` r
find_all_paths(graph, from, to)
```

## Arguments

- graph:

  A graph object

- from:

  The starting node of the path

- to:

  The ending node of the path

## Value

A list of character vectors

## See also

Other analyze graphs: [`find_path()`](find_path.md),
[`find_path_one_to_many()`](find_path_one_to_many.md),
[`get_all_leaves()`](get_all_leaves.md),
[`get_all_roots()`](get_all_roots.md),
[`get_leaves_under()`](get_leaves_under.md),
[`get_roots_over()`](get_roots_over.md),
[`least_common_parents()`](least_common_parents.md)

## Examples

``` r
graph <- graph_builder() |>
  add_path(c("A", "B", "C")) |>
  add_path(c("A", "Z", "C")) |>
  add_path(c("A", "B", "A")) |>
  build_directed()

find_all_paths(graph, "A", "C")
#> [[1]]
#> # of nodes: 3
#> |           Nodes           |
#> |             A             |
#> |             B             |
#> |             C             |
#> 
#> 
#> [[2]]
#> # of nodes: 3
#> |           Nodes           |
#> |             A             |
#> |             Z             |
#> |             C             |
#> 
#> 
```
