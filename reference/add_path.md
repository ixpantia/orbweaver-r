# Add a path to a graph

Adds all of the edges that make up the given path to the graph.

## Usage

``` r
add_path(graph_builder, path)
```

## Arguments

- graph_builder:

  A graph builder_object

- path:

  A character vector that describes the path

## Value

The updated graph builder object

## See also

Other build graphs: [`add_edge()`](add_edge.md),
[`build_acyclic()`](build_acyclic.md),
[`build_directed()`](build_directed.md),
[`graph_builder()`](graph_builder.md),
[`populate_edges()`](populate_edges.md)

## Examples

``` r
graph_builder() |>
  add_path(c("A", "B", "C"))
#> <pointer: 0x5607c959e920>
#> attr(,"class")
#> [1] "DirectedGraphBuilder"
```
