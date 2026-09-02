# Read the graph from a binary blob

Read the graph from a binary blob

## Usage

``` r
graph_from_bin(path, bin, type = c("directed", "dag"))
```

## Arguments

- path:

  (Optional) Path to a file containing a graph binary

- bin:

  (Optional) The raw binary of the graph

- type:

  The type of graph the JSON represents

## Value

A graph object

## See also

Other graphs i/o: [`graph_to_bin()`](graph_to_bin.md)

## Examples

``` r
bin <- graph_builder() |>
  add_edge("A", "B") |>
  build_directed() |>
  graph_to_bin()
bin
#>   [1] 00 00 00 00 0e 00 00 00 78 9c 55 cb 31 0a 84 30 10 85 e1 e4 68 bb b0 c5 9e
#>  [26] 42 06 f3 d4 d1 38 09 c9 20 68 67 6e 62 e5 35 0d 58 88 cd 2b 1e df 7f 0e 2c
#>  [51] 8a 24 48 85 3e f4 ed 3c 68 41 de 2d 52 08 9a 77 03 09 0e b9 18 eb db 81 bd
#>  [76] 4b 90 66 a6 78 b4 75 ca 31 fd 85 95 c9 f3 06 57 93 df 1c 75 1d 23 55 a4 8f
#> [101] ba ef b7 35 bd 34 70 3d b2 bd 00 fa e7 33 5b

graph_from_bin(bin = bin)
#> # of nodes: 2
#> # of edges: 1
#> # of roots: 1
#> # of leaves: 1
#> 
#> |     Parent      |      Child      |
#> | --------------- | --------------- |
#> | A               | B               |
#> 
```
