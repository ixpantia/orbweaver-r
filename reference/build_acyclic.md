# Build a DirectedAcyclicGraph from a builder

Builds a graph builder into a new DirectedAcyclicGraph object.

NOTE: This will consume the builder. It will leave an empty builder in
its place.

## Usage

``` r
build_acyclic(graph_builder)
```

## Arguments

- graph_builder:

  A graph builder object

## Value

A DirectedAcyclicGraph Object

## See also

Other build graphs: [`add_edge()`](add_edge.md),
[`add_path()`](add_path.md), [`build_directed()`](build_directed.md),
[`graph_builder()`](graph_builder.md),
[`populate_edges()`](populate_edges.md)

## Examples

``` r
graph_builder() |>
  add_path(c("1", "2", "3", "4")) |>
  build_acyclic()
#> # of nodes: 4
#> # of edges: 3
#> # of roots: 1
#> # of leaves: 1
#> 
#> |     Parent      |      Child      |
#> | --------------- | --------------- |
#> | 1               | 2               |
#> | 2               | 3               |
#> | 3               | 4               |
#> 
```
