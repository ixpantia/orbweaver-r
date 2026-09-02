# Get the children on a node

Get a list of the node ids of the children of the provided node.

## Usage

``` r
children(graph, nodes)
```

## Arguments

- graph:

  A graph object

- nodes:

  A character vector of nodes to find children for

## Value

A character vector

## Examples

``` r
graph <- graph_builder() |>
  add_edge(from = "A", to = "B") |>
  build_directed()

graph |> children("A")
#> # of nodes: 1
#> |           Nodes           |
#> |             B             |
#> 
```
