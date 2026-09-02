# orbweaver

``` r

library(orbweaver)
```

orbweaver helps you to build, manipulate and analyze directed and
acyclic graphs in R.

### Build

- [`graph_builder()`](../reference/graph_builder.md) initiates the
  process of building a graph.
- [`add_edge()`](../reference/add_edge.md) adds a directed edge between
  two nodes.
- [`add_path()`](../reference/add_path.md) adds a path to the graph.
- [`build_directed()`](../reference/build_directed.md) finalizes the
  graph as a directed graph.

``` r

graph <- graph_builder() |>
  add_edge(from = "a", to = "b") |>
  add_edge(from = "a", to = "c") |>
  add_edge(from = "b", to = "d") |>
  add_edge(from = "c", to = "d") |>
  add_path(path = c("a", "b", "d")) |>
  build_directed()
graph
#> # of nodes: 4
#> # of edges: 4
#> # of roots: 1
#> # of leaves: 1
#> 
#> |     Parent      |      Child      |
#> | --------------- | --------------- |
#> | a               | b               |
#> | a               | c               |
#> | b               | d               |
#> | c               | d               |
```

- [`populate_edges()`](../reference/populate_edges.md) populates edges
  of a graph from a data frame.
- [`build_acyclic()`](../reference/build_acyclic.md) finalizes the graph
  as an acyclic graph.

``` r

edges <- data.frame(
  parent = c("a", "a", "b", "c"),
  child = c("b", "c", "d", "d")
)

acyclic_graph <- graph_builder() |>
  populate_edges(edges_df = edges, parent_col = parent, child_col = child) |>
  build_acyclic()
acyclic_graph
#> # of nodes: 4
#> # of edges: 4
#> # of roots: 1
#> # of leaves: 1
#> 
#> |     Parent      |      Child      |
#> | --------------- | --------------- |
#> | a               | b               |
#> | a               | c               |
#> | b               | d               |
#> | c               | d               |
```

### i/o

- [`graph_to_bin()`](../reference/graph_to_bin.md) writes a graph to a
  file or memory.
- [`graph_from_bin()`](../reference/graph_from_bin.md) reads a graph
  from a file or memory.

``` r

file <- tempfile()
graph_to_bin(graph, path = file)
#> NULL
graph_from_bin(path = file, type = "directed")
#> # of nodes: 4
#> # of edges: 4
#> # of roots: 1
#> # of leaves: 1
#> 
#> |     Parent      |      Child      |
#> | --------------- | --------------- |
#> | a               | b               |
#> | a               | c               |
#> | b               | d               |
#> | c               | d               |

bin <- graph_to_bin(graph)
graph_from_bin(bin = bin, type = "directed")
#> # of nodes: 4
#> # of edges: 4
#> # of roots: 1
#> # of leaves: 1
#> 
#> |     Parent      |      Child      |
#> | --------------- | --------------- |
#> | a               | b               |
#> | a               | c               |
#> | b               | d               |
#> | c               | d               |
```

### Explore

- [`has_children()`](../reference/has_children.md) checks whether a node
  has children.

``` r

has_children(graph, nodes = "a")
#> [1] TRUE
has_children(graph, nodes = "d")
#> [1] FALSE
```

- [`has_parents()`](../reference/has_parents.md) checks whether a node
  has parents.

``` r

has_parents(graph, nodes = "a")
#> [1] FALSE
has_parents(graph, nodes = "d")
#> [1] TRUE
```

- [`subset()`](https://rdrr.io/r/base/subset.html) subsets a graph to
  include only specific nodes.

``` r

subset(graph, nodes = c("a", "b", "d"))
#> # of nodes: 4
#> # of edges: 4
#> # of roots: 1
#> # of leaves: 1
#> 
#> |     Parent      |      Child      |
#> | --------------- | --------------- |
#> | a               | b               |
#> | a               | c               |
#> | b               | d               |
#> | c               | d               |
```

- [`length()`](https://rdrr.io/r/base/length.html) returns the number of
  nodes in a graph.

``` r

length(graph)
#> [1] 4
```

- [`nodes()`](../reference/nodes.md) returns all nodes in a graph.

``` r

nodes(graph)
#> # of nodes: 4
#> |           Nodes           |
#> |             a             |
#> |             b             |
#> |             c             |
#> |             d             |
```

- [`children()`](../reference/children.md) returns the children of a
  specific node in a graph.

``` r

children(graph, node = "a")
#> # of nodes: 2
#> |           Nodes           |
#> |             b             |
#> |             c             |
```

- [`parents()`](../reference/parents.md) returns the parents of a
  specific node in a graph.

``` r

parents(graph, node = "d")
#> # of nodes: 2
#> |           Nodes           |
#> |             b             |
#> |             c             |
```

### Analyze

- [`find_path()`](../reference/find_path.md) finds a path between two
  nodes.

``` r

find_path(graph, from = "a", to = "d")
#> # of nodes: 3
#> |           Nodes           |
#> |             a             |
#> |             b             |
#> |             d             |
```

- [`find_all_paths()`](../reference/find_all_paths.md) finds all paths
  between two nodes.

``` r

find_all_paths(graph, from = "a", to = "d")
#> [[1]]
#> # of nodes: 3
#> |           Nodes           |
#> |             a             |
#> |             b             |
#> |             d             |
#> 
#> 
#> [[2]]
#> # of nodes: 3
#> |           Nodes           |
#> |             a             |
#> |             c             |
#> |             d             |
```

- [`find_path_one_to_many()`](../reference/find_path_one_to_many.md)
  finds a valid path from one node to multiple destinations in a
  directed graph.

``` r

find_path_one_to_many(acyclic_graph, from = "a", to = edges$child)
#> [[1]]
#> # of nodes: 2
#> |           Nodes           |
#> |             a             |
#> |             b             |
#> 
#> 
#> [[2]]
#> # of nodes: 2
#> |           Nodes           |
#> |             a             |
#> |             c             |
#> 
#> 
#> [[3]]
#> # of nodes: 3
#> |           Nodes           |
#> |             a             |
#> |             b             |
#> |             d             |
#> 
#> 
#> [[4]]
#> # of nodes: 3
#> |           Nodes           |
#> |             a             |
#> |             b             |
#> |             d             |
```

- [`get_all_leaves()`](../reference/get_all_leaves.md) returns all leaf
  nodes in a graph.

``` r

get_all_leaves(graph)
#> # of nodes: 1
#> |           Nodes           |
#> |             d             |
```

- [`get_all_roots()`](../reference/get_all_roots.md) returns all root
  nodes in a graph.

``` r

get_all_roots(graph)
#> # of nodes: 1
#> |           Nodes           |
#> |             a             |
```

- [`get_leaves_under()`](../reference/get_leaves_under.md) returns all
  leaf nodes under a specific node in a graph.

``` r

get_leaves_under(graph, node = "a")
#> # of nodes: 1
#> |           Nodes           |
#> |             d             |
```

- [`get_roots_over()`](../reference/get_roots_over.md) returns all root
  nodes over a specific node in a graph.

``` r

get_roots_over(graph, node = "d")
#> # of nodes: 1
#> |           Nodes           |
#> |             a             |
```

- [`least_common_parents()`](../reference/least_common_parents.md)
  returns the least common parents of a set of nodes in a graph.

``` r

least_common_parents(graph, selected = c("d", "c"))
#> # of nodes: 1
#> |           Nodes           |
#> |             c             |
```
