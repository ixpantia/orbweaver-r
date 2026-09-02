# Get the parents on a node

Get a list of the node ids of the parents of the provided node.

## Usage

``` r
parents(graph, nodes)
```

## Arguments

- graph:

  A graph object

- nodes:

  A character vector of nodes to find parents for

## Value

A character vector

## Examples

``` r
graph <- graph_builder() |>
  add_edge(from = "A", to = "B") |>
  build_directed()

graph |> parents("A")
#> # of nodes: 0
#> |           Nodes           |
#> 
graph |> parents("B")
#> # of nodes: 1
#> |           Nodes           |
#> |             A             |
#> 
```
