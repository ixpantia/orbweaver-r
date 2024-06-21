library(igraph)
library(orbweaver)
library(microbenchmark)

# Download the dataset from the orbweaver-rs repo
edges <- readr::read_tsv("https://raw.githubusercontent.com/ixpantia/orbweaver-rs/main/assets/medium.txt", col_names = c("parent", "child"))

# Function to convert dataframe to orbweaver graph
df_to_orbweaver <- function(edges) {
  graph_builder() |>
    populate_edges(edges, parent, child) |>
    build_acyclic()
}

# Function to convert dataframe to igraph graph
df_to_igraph <- function(edges) {
  graph_from_data_frame(edges, directed = TRUE)
}

find_paths_orbweaver <- function(graph, from, to) {
  orbweaver::find_all_paths(graph, from, to)
}

find_paths_igraph <- function(graph, from, to) {
  igraph::all_shortest_paths(graph, from, to)
}

find_path_orbweaver <- function(graph, from, to) {
  orbweaver::find_path(graph, from, to)
}

find_path_igraph <- function(graph, from, to) {
  igraph::shortest_paths(graph, from, to)$vpath
}

get_nodes_orbweaver <- function(graph) {
  orbweaver::nodes(graph)
}

get_nodes_igraph <- function(graph) {
  igraph::V(graph)
}

get_leaves_under_orbweaver <- function(graph, node) {
  orbweaver::get_leaves_under(graph, node)
}

get_leaves_under_igraph <- function(graph, node) {
  descendants <- igraph::ego(graph, order = length(V(graph)), nodes = node, mode = "out")[[1]]
  descendants[igraph::degree(graph, v = descendants, mode = "out") == 0]
}

get_roots_over_orbweaver <- function(graph, node) {
  orbweaver::get_roots_over(graph, node)
}

get_roots_over_igraph <- function(graph, node) {
  ancestors <- igraph::ego(graph, order = length(V(graph)), nodes = node, mode = "in")[[1]]
  ancestors[igraph::degree(graph, v = ancestors, mode = "in") == 0]
}

least_common_parents_orbweaver <- function(graph, nodes) {
  orbweaver::least_common_parents(graph, nodes)
}

least_common_parents_igraph <- function(graph, nodes) {
  subgraph <- igraph::induced_subgraph(graph, nodes)
  igraph::V(subgraph)[igraph::degree(subgraph, mode = "in") == 0]
}

subset_orbweaver <- function(graph, node) {
  subset(graph, node)
}

subset_igraph <- function(graph, node) {
  reachable_nodes <- igraph::ego(graph, order = length(igraph::V(graph)), nodes = node, mode = "out")[[1]]
  igraph::induced_subgraph(graph, reachable_nodes)
}

# Create orbweaver and igraph graphs
g_orb <- df_to_orbweaver(edges)
g_ig <- df_to_igraph(edges)

# Benchmark the functions
microbenchmark(
  find_all_paths_orbweaver = find_paths_orbweaver(g_orb, "1781f676dedf5767f3243db0a9738b35", "eb85851afd251bd7c7eaf725d0d19360"),
  find_all_paths_igraph = find_paths_igraph(g_ig, "1781f676dedf5767f3243db0a9738b35", "eb85851afd251bd7c7eaf725d0d19360"),
  find_path_orbweaver = find_path_orbweaver(g_orb, "1781f676dedf5767f3243db0a9738b35", "eb85851afd251bd7c7eaf725d0d19360"),
  find_path_igraph = find_path_igraph(g_ig, "1781f676dedf5767f3243db0a9738b35", "eb85851afd251bd7c7eaf725d0d19360"),
  get_leaves_under_orbweaver = get_leaves_under_orbweaver(g_orb, "1781f676dedf5767f3243db0a9738b35"),
  get_leaves_under_igraph = get_leaves_under_igraph(g_ig, "1781f676dedf5767f3243db0a9738b35"),
  get_roots_over_orbweaver = get_roots_over_orbweaver(g_orb, "eb85851afd251bd7c7eaf725d0d19360"),
  get_roots_over_igraph = get_roots_over_igraph(g_ig, "eb85851afd251bd7c7eaf725d0d19360"),
  least_common_parents_orbweaver = least_common_parents_orbweaver(g_orb, edges$parent[1:100]),
  least_common_parents_igraph = least_common_parents_igraph(g_ig, edges$parent[1:100]),
  subset_orbweaver = subset_orbweaver(g_orb, "1781f676dedf5767f3243db0a9738b35"),
  subset_igraph = subset_igraph(g_ig, "1781f676dedf5767f3243db0a9738b35"),
  times = 100
)
