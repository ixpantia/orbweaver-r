
# orbweaver <a><img src="https://storage.googleapis.com/ix-paquetes-internos/logo-orbweaver.png" align="right" width="30%"></a>

<!-- badges: start -->
[![CRAN status](https://www.r-pkg.org/badges/version/orbweaver)](https://cran.r-project.org/package=orbweaver)
[![R-CMD-check](https://github.com/ixpantia/orbweaver/actions/workflows/check-full.yaml/badge.svg)](https://github.com/ixpantia/orbweaver/actions/workflows/check-full.yaml)
<!-- badges: end -->

## Overview

A fast R library for working with Nodes in a graph.

## Features

 - Find shortest paths between nodes in a graph
 - Find the common parents between selected nodes
 - Directed Graph
 - Directed Acyclic Graph
 - It is quite fast

## Why not igraph?

[igraph](https://igraph.org/) is an amazing network analysis package.
igraph is much more mature and orbweaver focuses on extreme performance
and low latency operations. If you need super high performance
and do not require weighted graphs, orbweaver may be for you.

![igraph vs orbweaver benchmark](man/figures/benchmark.png)

> We may add weighted graph in the future but for not
> it is not in the short-term road map.

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

If you are on Windows you may need to install `Rtools` as
well. You can download the installer from
[here](https://cran.r-project.org/bin/windows/Rtools/).

### R Package

Once you have the Rust toolchain installed, you can install
this package from Git using whatever method you prefer.

With `remotes`:

```R
remotes::install_github("ixpantia/orbweaver")
```

With `devtools`:

```R
devtools::install_github("ixpantia/orbweaver")
```

With `renv`:

```R
renv::install("ixpantia/orbweaver")
```

With `pak`:

```R
pak::pak("ixpantia/orbweaver")
```
