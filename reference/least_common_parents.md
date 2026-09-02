# Find the least common parents in a graph

It finds the nodes that have no parents in the given set.

## Usage

``` r
least_common_parents(graph, selected)
```

## Arguments

- graph:

  A graph object

- selected:

  A character vector of node ids

## Value

A character vector of node ids

## See also

Other analyze graphs: [`find_all_paths()`](find_all_paths.md),
[`find_path()`](find_path.md),
[`find_path_one_to_many()`](find_path_one_to_many.md),
[`get_all_leaves()`](get_all_leaves.md),
[`get_all_roots()`](get_all_roots.md),
[`get_leaves_under()`](get_leaves_under.md),
[`get_roots_over()`](get_roots_over.md)

## Examples

``` r
graph_edges <- data.frame(
  parent = c("A", "B", "C", "C", "F"),
  child = c("B", "C", "D", "E", "D")
)

graph <- graph_builder() |>
  populate_edges(graph_edges, parent, child) |>
  build_directed()
graph
#> # of nodes: 6
#> # of edges: 5
#> # of roots: 2
#> # of leaves: 2
#> 
#> |     Parent      |      Child      |
#> | --------------- | --------------- |
#> | A               | B               |
#> | B               | C               |
#> | C               | E               |
#> | C               | D               |
#> | F               | D               |
#> 

graph |> least_common_parents(c("D", "E"))
#> # of nodes: 2
#> |           Nodes           |
#> |             D             |
#> |             E             |
#> 
```
