# Get the all the root nodes of a graph

Retrieves the nodes in a graph that have no parents

## Usage

``` r
get_all_roots(graph, ...)
```

## Arguments

- graph:

  A graph object

- ...:

  Unused

## Value

A character vector of nodes

## See also

Other analyze graphs: [`find_all_paths()`](find_all_paths.md),
[`find_path()`](find_path.md),
[`find_path_one_to_many()`](find_path_one_to_many.md),
[`get_all_leaves()`](get_all_leaves.md),
[`get_leaves_under()`](get_leaves_under.md),
[`get_roots_over()`](get_roots_over.md),
[`least_common_parents()`](least_common_parents.md)

## Examples

``` r
graph <- graph_builder() |>
  add_path(c("A", "B", "C")) |>
  add_path(c("A", "D", "C")) |>
  add_path(c("Z", "B", "C")) |>
  build_directed()

get_all_roots(graph)
#> # of nodes: 2
#> |           Nodes           |
#> |             A             |
#> |             Z             |
#> 
```
