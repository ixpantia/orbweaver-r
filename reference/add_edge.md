# Add an edge to a graph builder

Adds an edge from one node to another in a a directed graph builder.

## Usage

``` r
add_edge(graph_builder, from, to)
```

## Arguments

- graph_builder:

  A graph builder_object

- from:

  The `from` node.

- to:

  The `to` node.

## Value

The updated graph builder object

## See also

Other build graphs: [`add_path()`](add_path.md),
[`build_acyclic()`](build_acyclic.md),
[`build_directed()`](build_directed.md),
[`graph_builder()`](graph_builder.md),
[`populate_edges()`](populate_edges.md)

## Examples

``` r
graph_builder() |>
  add_edge("A", "B")
#> <pointer: 0x5607c95b67f0>
#> attr(,"class")
#> [1] "DirectedGraphBuilder"
```
