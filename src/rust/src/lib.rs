use extendr_api::prelude::*;
use orbweaver::prelude as ow;
use std::io::{BufReader, BufWriter};

pub mod from_dataframe;
mod macros;

pub struct DirectedGraphBuilder(ow::DirectedGraphBuilder);
pub struct DirectedGraph(ow::DirectedGraph);
pub struct DirectedAcyclicGraph(ow::DirectedAcyclicGraph);

pub fn to_r_error(err: impl std::error::Error) -> Error {
    err.to_string().into()
}

#[extendr]
impl DirectedGraphBuilder {
    fn new() -> Self {
        DirectedGraphBuilder(ow::DirectedGraphBuilder::new())
    }
    fn add_edge(&mut self, from: &str, to: &str) {
        self.0.add_edge(from, to);
    }
    fn add_path(&mut self, path: Strings) {
        self.0.add_path(path.iter());
    }
    /// This will empty the builder
    fn build_directed(&mut self) -> DirectedGraph {
        let mut new_builder = Self::new();
        std::mem::swap(self, &mut new_builder);
        DirectedGraph(new_builder.0.build_directed())
    }
    /// This will empty the builder
    fn build_acyclic(&mut self) -> Result<DirectedAcyclicGraph> {
        let mut new_builder = Self::new();
        std::mem::swap(self, &mut new_builder);
        Ok(DirectedAcyclicGraph(
            new_builder.0.build_acyclic().map_err(to_r_error)?,
        ))
    }
}

trait ImplDirectedGraph: Sized {
    fn find_path(&self, from: &str, to: &str) -> Result<Vec<&str>>;
    fn children(&self, nodes: Strings) -> Vec<&str>;
    fn parents(&self, nodes: Strings) -> Vec<&str>;
    fn has_parents(&self, nodes: Strings) -> Result<Vec<bool>>;
    fn has_children(&self, nodes: Strings) -> Result<Vec<bool>>;
    fn least_common_parents(&self, selected: Strings) -> Result<Vec<&str>>;
    fn get_all_leaves(&self) -> Vec<&str>;
    fn get_leaves_under(&self, nodes: Strings) -> Result<Vec<&str>>;
    fn get_all_roots(&self) -> Vec<String>;
    fn get_roots_over(&self, node_ids: Vec<String>) -> Result<Vec<&str>>;
    fn subset(&self, node_id: &str) -> Result<Self>;
    fn print(&self);
    fn find_all_paths(&self, from: &str, to: &str) -> Result<List>;
    fn to_bin_disk(&self, path: &str) -> Result<()>;
    fn to_bin_mem(&self) -> Result<Vec<u8>>;
    fn from_bin_disk(path: &str) -> Result<Self>;
    fn from_bin_mem(bin: &[u8]) -> Result<Self>;
    fn nodes(&self) -> Vec<&str>;
    fn length(&self) -> i32;
}

#[extendr]
impl ImplDirectedGraph for DirectedGraph {
    fn find_path(&self, from: &str, to: &str) -> Result<Vec<&str>> {
        self.0.find_path(from, to).map_err(to_r_error)
    }
    fn children(&self, nodes: Strings) -> Vec<&str> {
        self.0.children(nodes.iter()).unwrap_or_default()
    }
    fn parents(&self, nodes: Strings) -> Vec<&str> {
        self.0.parents(nodes.iter()).unwrap_or_default()
    }
    fn has_parents(&self, nodes: Strings) -> Result<Vec<bool>> {
        self.0.has_parents(nodes.iter()).map_err(to_r_error)
    }
    fn has_children(&self, nodes: Strings) -> Result<Vec<bool>> {
        self.0.has_children(nodes.iter()).map_err(to_r_error)
    }
    fn least_common_parents(&self, selected: Strings) -> Result<Vec<&str>> {
        self.0
            .least_common_parents(selected.iter())
            .map_err(to_r_error)
    }
    fn get_all_leaves(&self) -> Vec<&str> {
        self.0.get_all_leaves().into_iter().collect()
    }
    fn get_leaves_under(&self, nodes: Strings) -> Result<Vec<&str>> {
        Ok(self
            .0
            .get_leaves_under(nodes.iter())
            .map_err(to_r_error)?
            .into_iter()
            .collect())
    }
    fn get_all_roots(&self) -> Vec<String> {
        self.0
            .get_all_roots()
            .into_iter()
            .map(String::from)
            .collect()
    }
    fn get_roots_over(&self, node_ids: Vec<String>) -> Result<Vec<&str>> {
        self.0.get_roots_over(&node_ids).map_err(to_r_error)
    }
    fn subset(&self, node_id: &str) -> Result<Self> {
        Ok(Self(self.0.subset(node_id).map_err(to_r_error)?))
    }
    fn print(&self) {
        println!("{:?}", self.0)
    }

    fn to_bin_disk(&self, path: &str) -> Result<()> {
        let writer = BufWriter::new(
            std::fs::File::options()
                .write(true)
                .create(true)
                .truncate(true)
                .open(path)
                .map_err(to_r_error)?,
        );
        self.0.to_binary(writer).map_err(to_r_error)
    }

    fn to_bin_mem(&self) -> Result<Vec<u8>> {
        let mut writer = Vec::new();
        self.0.to_binary(&mut writer).map_err(to_r_error)?;
        Ok(writer)
    }

    fn from_bin_disk(path: &str) -> Result<Self> {
        let file = BufReader::new(std::fs::File::open(path).map_err(to_r_error)?);
        ow::DirectedGraph::from_binary(file)
            .map(DirectedGraph)
            .map_err(to_r_error)
    }

    fn from_bin_mem(bin: &[u8]) -> Result<Self> {
        ow::DirectedGraph::from_binary(bin)
            .map(DirectedGraph)
            .map_err(to_r_error)
    }

    fn nodes(&self) -> Vec<&str> {
        self.0.nodes()
    }

    fn length(&self) -> i32 {
        self.0.len() as i32
    }

    fn find_all_paths(&self, _from: &str, _to: &str) -> Result<List> {
        todo!("Find all paths is not implemented for DirectedGraph")
    }
}

#[extendr]
impl ImplDirectedGraph for DirectedAcyclicGraph {
    fn find_path(&self, from: &str, to: &str) -> Result<Vec<&str>> {
        self.0.find_path(from, to).map_err(to_r_error)
    }
    fn children(&self, nodes: Strings) -> Vec<&str> {
        self.0.children(nodes.iter()).unwrap_or_default()
    }
    fn parents(&self, nodes: Strings) -> Vec<&str> {
        self.0.parents(nodes.iter()).unwrap_or_default()
    }
    fn has_parents(&self, nodes: Strings) -> Result<Vec<bool>> {
        self.0.has_parents(nodes.iter()).map_err(to_r_error)
    }
    fn has_children(&self, nodes: Strings) -> Result<Vec<bool>> {
        self.0.has_children(nodes.iter()).map_err(to_r_error)
    }
    fn least_common_parents(&self, selected: Strings) -> Result<Vec<&str>> {
        self.0
            .least_common_parents(selected.iter())
            .map_err(to_r_error)
    }
    fn get_all_leaves(&self) -> Vec<&str> {
        self.0.get_all_leaves().into_iter().collect()
    }
    fn get_leaves_under(&self, nodes: Strings) -> Result<Vec<&str>> {
        Ok(self
            .0
            .get_leaves_under(nodes.iter())
            .map_err(to_r_error)?
            .into_iter()
            .collect())
    }
    fn get_all_roots(&self) -> Vec<String> {
        self.0
            .get_all_roots()
            .into_iter()
            .map(String::from)
            .collect()
    }
    fn get_roots_over(&self, node_ids: Vec<String>) -> Result<Vec<&str>> {
        self.0.get_roots_over(&node_ids).map_err(to_r_error)
    }
    fn subset(&self, node_id: &str) -> Result<Self> {
        Ok(Self(self.0.subset(node_id).map_err(to_r_error)?))
    }
    fn print(&self) {
        println!("{:?}", self.0)
    }

    fn to_bin_disk(&self, path: &str) -> Result<()> {
        let writer = BufWriter::new(
            std::fs::File::options()
                .write(true)
                .create(true)
                .truncate(true)
                .open(path)
                .map_err(to_r_error)?,
        );
        self.0.to_binary(writer).map_err(to_r_error)
    }

    fn to_bin_mem(&self) -> Result<Vec<u8>> {
        let mut writer = Vec::new();
        self.0.to_binary(&mut writer).map_err(to_r_error)?;
        Ok(writer)
    }

    fn from_bin_disk(path: &str) -> Result<Self> {
        let file = BufReader::new(std::fs::File::open(path).map_err(to_r_error)?);
        ow::DirectedAcyclicGraph::from_binary(file)
            .map(DirectedAcyclicGraph)
            .map_err(to_r_error)
    }

    fn from_bin_mem(bin: &[u8]) -> Result<Self> {
        ow::DirectedAcyclicGraph::from_binary(bin)
            .map(DirectedAcyclicGraph)
            .map_err(to_r_error)
    }

    fn nodes(&self) -> Vec<&str> {
        self.0.nodes()
    }

    fn length(&self) -> i32 {
        self.0.len() as i32
    }

    fn find_all_paths(&self, from: &str, to: &str) -> Result<List> {
        Ok(self
            .0
            .find_all_paths(from, to)
            .map_err(to_r_error)?
            .into_iter()
            .collect())
    }
}

// Macro to generate exports.
// This ensures exported functions are registered with R.
// See corresponding C code in `entrypoint.c`.
extendr_module! {
    mod orbweaver;
    impl DirectedGraph;
    impl DirectedAcyclicGraph;
    impl DirectedGraphBuilder;
    use from_dataframe;
}
