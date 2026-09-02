# Checks if a node in a graph has children

This function validates if the node has an edge pointing to any other
node.

## Usage

``` r
has_children(graph, nodes)
```

## Arguments

- graph:

  A graph object

- nodes:

  A character vector of nodes to determine

## Value

A logical vector with the same length as `nodes`

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

graph |> has_children(nodes = "A")
#> [1] TRUE
graph |> has_children(nodes = "B")
#> [1] FALSE
```
