# Nodes

A fast R library for working with Nodes in a graph. This library
modifies graphs in place, similar to how [data.table](https://github.com/Rdatatable/data.table)
modifies data.frames in place. This allows for fast and memory efficient
graph operations.

## Features

 - Acyclic directed graph
   - Get root nodes
   - Get leaf nodes
   - Get parents of a node
   - Get children of a node
   - Get least common ancestor/parents in a set of nodes
   - Convert to a list (for use in libraries like [shinyTree](https://github.com/shinyTree/shinyTree)).
   - Create from a data.frame

## Usage

### Create an Acyclic Graph manually

In this example we will build the graph manually.

```R
library(noder)

tree <- new_acyclic_graph() |>
  # Node A has children B and C
  add_child("A", "B") |>
  add_child("A", "C") |>
  # Node B has children D and E
  add_child("B", "D") |>
  add_child("B", "E") |>
  # Node C has child F
  add_child("C", "F")

tree |>
  find_roots()
# [1] "A"

tree |>
  find_leaves("A")
# [1] "F" "E" "D"

tree |>
  find_least_common_parents(c("B", "D", "E"))
# [1] "B"
```

### Create an Acyclic Graph from a data.frame / derivative

```R
library(noder)

df <- data.frame(
  parent = c("A", "A", "B", "B", "C"),
  child = c("B", "C", "D", "E", "F")
)

tree <- acyclic_graph_from_df(df)

tree |>
  find_roots()
# [1] "A"

tree |>
  find_leaves("A")
# [1] "F" "E" "D"

tree |>
  find_least_common_parents(c("B", "D", "E"))
# [1] "B"
```

### Convert to a list

```R
library(noder)

tree <- new_acyclic_graph() |>
  # Node A has children B and C
  add_child("A", "B") |>
  add_child("A", "C") |>
  # Node B has children D and E
  add_child("B", "D") |>
  add_child("B", "E") |>
  # Node C has child F
  add_child("C", "F")

tree |>
  as.list()
# $A
# $A$C
# $A$C$F
# [1] ""
# 
# 
# $A$B
# $A$B$D
# [1] ""
# 
# $A$B$E
# [1] ""
```

## Installation

### Rust Toolchain

Before installing this package, you will need to install the
Rust toolchain. If you are on Mac or Linux, you can do this
by running the following command in your terminal:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

#### Windows

If you are on Windows, you can download the installer from
[here](https://www.rust-lang.org/tools/install).

In order to compile this package manually, you will need the
**GNU ABI** used by the **GCC toolchain**. This is not the
default on Windows, so you will need to install the
toolchain manually. You can do this by running the following
command in your terminal:

```bash
rustup toolchain install stable-gnu
```

If you are on Windows you may been to install `Rtools` as
well. You can download the installer from
[here](https://cran.r-project.org/bin/windows/Rtools/).

### R Package

Once you have the Rust toolchain installed, you can install
this package from Git using whatever method you prefer.

With `remotes`:

```R
remotes::install_git("https://secure.ixpantia.com/imasd/noder.git")
```

With `devtools`:

```R
devtools::install_git("https://secure.ixpantia.com/imasd/noder.git")
```

With `renv`:

```R
renv::install("https://secure.ixpantia.com/imasd/noder.git")
```
