# Find a path between two nodes

Finds a path between two nodes in a graph.

Different types of graphs use different algorithms to find the paths. a
`DirectedGraph` uses breadth-first search while an
`DirectedAcyclicGraph` uses topological sort.

The path is represented as a character vector with the node ids of the
nodes that make up the path.

## Usage

``` r
find_path(graph, from, to)
```

## Arguments

- graph:

  A graph object

- from:

  The starting node of the path

- to:

  The ending node of the path

## Value

A character vector

## See also

Other analyze graphs: [`find_all_paths()`](find_all_paths.md),
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
  build_directed()

find_path(graph, "A", "C")
#> # of nodes: 3
#> |           Nodes           |
#> |             A             |
#> |             B             |
#> |             C             |
#> 
```
