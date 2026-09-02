# Populates the edges of a graph from a `data.frame`

Adds a set of edges from a `data.frame` to a graph

## Usage

``` r
populate_edges(graph_builder, edges_df, parent_col, child_col)
```

## Arguments

- graph_builder:

  A graph builder object

- edges_df:

  A `data.frame` with a parent and child variable

- parent_col:

  The name of the column containing the parents

- child_col:

  The name of the column containing the children

## Value

The updated graph builder object

## See also

Other build graphs: [`add_edge()`](add_edge.md),
[`add_path()`](add_path.md), [`build_acyclic()`](build_acyclic.md),
[`build_directed()`](build_directed.md),
[`graph_builder()`](graph_builder.md)

## Examples

``` r
graph_edges <- data.frame(
  parent = c("A", "B", "C"),
  child = c("B", "C", "D")
)

graph_builder() |>
  populate_edges(
    edges_df = graph_edges,
    parent_col = "parent",
    child_col = "child"
  )
#> <pointer: 0x5607c8eecd90>
#> attr(,"class")
#> [1] "DirectedGraphBuilder"
```
