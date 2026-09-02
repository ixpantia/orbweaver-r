# Get the nodes in the graph

Returns the unique nodes in the graph

## Usage

``` r
nodes(graph, ...)
```

## Arguments

- graph:

  A directed or directed acyclic graph

- ...:

  Reserved for later use

## Value

A character vector with the nodes

## Examples

``` r
graph <- graph_builder() |>
  add_edge(from = "A", to = "B") |>
  build_directed()
graph
#> # of nodes: 2
#> # of edges: 1
#> # of roots: 1
#> # of leaves: 1
#> 
#> |     Parent      |      Child      |
#> | --------------- | --------------- |
#> | A               | B               |
#> 

nodes(graph)
#> # of nodes: 2
#> |           Nodes           |
#> |             A             |
#> |             B             |
#> 
```
