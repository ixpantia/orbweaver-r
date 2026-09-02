# A new builder for a graph based on the type

Object used to build graphs

## Usage

``` r
graph_builder(type = c("directed"))
```

## Arguments

- type:

  The type of graph

## Value

An object of class 'DirectedGraphBuilder'.

## See also

Other build graphs: [`add_edge()`](add_edge.md),
[`add_path()`](add_path.md), [`build_acyclic()`](build_acyclic.md),
[`build_directed()`](build_directed.md),
[`populate_edges()`](populate_edges.md)

## Examples

``` r
graph_builder()
#> <pointer: 0x5607c92b00c0>
#> attr(,"class")
#> [1] "DirectedGraphBuilder"
```
