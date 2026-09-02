# Get the root nodes of a graph over some nodes

Retrieves the nodes in a graph that have no parents over a certain node
or group of nodes

## Usage

``` r
get_roots_over(graph, nodes)
```

## Arguments

- graph:

  A graph object

- nodes:

  A character vector of nodes to find roots for

## Value

A character vector of nodes

## See also

Other analyze graphs: [`find_all_paths()`](find_all_paths.md),
[`find_path()`](find_path.md),
[`find_path_one_to_many()`](find_path_one_to_many.md),
[`get_all_leaves()`](get_all_leaves.md),
[`get_all_roots()`](get_all_roots.md),
[`get_leaves_under()`](get_leaves_under.md),
[`least_common_parents()`](least_common_parents.md)

## Examples

``` r
graph <- graph_builder() |>
  add_path(c("A", "B", "C")) |>
  add_path(c("A", "D", "C")) |>
  add_path(c("Z", "B", "C")) |>
  build_directed()

get_roots_over(graph, "D")
#> # of nodes: 1
#> |           Nodes           |
#> |             A             |
#> 
```
