use extendr_api::prelude::*;
pub use ow::prelude as ow;
use std::io::{BufReader, BufWriter};

pub mod from_dataframe;
mod macros;

#[extendr]
pub struct DirectedGraphBuilder(ow::DirectedGraphBuilder);

#[extendr]
pub struct DirectedGraph(ow::DirectedGraph);

#[extendr]
pub struct DirectedAcyclicGraph(ow::DirectedAcyclicGraph);

#[extendr]
pub struct NodeVec(ow::NodeVec);

#[extendr]
pub enum RNodesIn {
    NodeVec(ow::NodeVec),
    Strings(Strings),
}

impl RNodesIn {
    pub fn iter(&self) -> RNodesInIter<'_> {
        RNodesInIter { vars: self, i: 0 }
    }
}

impl TryFrom<Robj> for RNodesIn {
    type Error = &'static str;
    fn try_from(value: Robj) -> std::prelude::v1::Result<Self, Self::Error> {
        if let Ok(node_vec) = <&NodeVec>::try_from(value.clone()) {
            return Ok(RNodesIn::NodeVec(node_vec.0.clone()));
        }
        if let Ok(strings) = Strings::try_from(value) {
            return Ok(RNodesIn::Strings(strings));
        }
        Err("The nodes must be a NodeVec or a character vector")
    }
}

pub struct RNodesInIter<'a> {
    vars: &'a RNodesIn,
    i: usize,
}

impl<'a> Iterator for RNodesInIter<'a> {
    type Item = &'a str;
    fn next(&mut self) -> Option<Self::Item> {
        let val = match &self.vars {
            RNodesIn::NodeVec(nv) => nv.get(self.i),
            RNodesIn::Strings(strs) => <[Rstr]>::get(strs, self.i).map(AsRef::as_ref),
        };
        self.i += 1;
        val
    }
}

impl From<ow::NodeVec> for NodeVec {
    #[inline]
    fn from(value: ow::NodeVec) -> Self {
        NodeVec(value)
    }
}

#[extendr]
impl NodeVec {
    pub fn print(&self) -> String {
        format!("{:?}", self.0)
    }
    pub fn as_character(&self) -> Robj {
        self.0.into_iter().collect_robj()
    }
    pub fn len(&self) -> i32 {
        self.0.len() as i32
    }
    pub fn is_empty(&self) -> bool {
        self.len() == 0
    }
}

impl NodeVec {
    pub fn as_inner(&self) -> &ow::NodeVec {
        &self.0
    }
    pub fn as_inner_mut(&mut self) -> &mut ow::NodeVec {
        &mut self.0
    }
    pub fn into_inner(self) -> ow::NodeVec {
        self.0
    }
    pub fn from_inner(inner: ow::NodeVec) -> Self {
        Self(inner)
    }
}

pub fn to_r_error(err: impl std::error::Error) -> Error {
    err.to_string().into()
}

impl Default for DirectedGraphBuilder {
    fn default() -> Self {
        Self::new()
    }
}

#[extendr]
impl DirectedGraphBuilder {
    pub fn new() -> Self {
        DirectedGraphBuilder(ow::DirectedGraphBuilder::new())
    }
    pub fn add_edge(&mut self, from: &str, to: &str) {
        self.0.add_edge(from, to);
    }
    pub fn add_path(&mut self, path: Strings) -> Result<()> {
        self.0.add_path(path.iter()).map_err(|e| e.to_string())?;
        Ok(())
    }
    /// This will empty the builder
    pub fn build_directed(&mut self) -> DirectedGraph {
        let mut new_builder = Self::new();
        std::mem::swap(self, &mut new_builder);
        DirectedGraph(new_builder.0.build_directed())
    }
    /// This will empty the builder
    pub fn build_acyclic(&mut self) -> Result<DirectedAcyclicGraph> {
        let mut new_builder = Self::new();
        std::mem::swap(self, &mut new_builder);
        Ok(DirectedAcyclicGraph(
            new_builder.0.build_acyclic().map_err(to_r_error)?,
        ))
    }
}

impl DirectedGraphBuilder {
    pub fn as_inner(&self) -> &ow::DirectedGraphBuilder {
        &self.0
    }
    pub fn as_inner_mut(&mut self) -> &mut ow::DirectedGraphBuilder {
        &mut self.0
    }
    pub fn into_inner(self) -> ow::DirectedGraphBuilder {
        self.0
    }
    pub fn from_inner(inner: ow::DirectedGraphBuilder) -> Self {
        Self(inner)
    }
}

pub trait RImplDirectedGraph: Sized {
    fn find_path(&self, from: &str, to: &str) -> Result<NodeVec>;
    fn find_path_one_to_many(&self, from: &str, to: Strings) -> Result<List>;
    fn children(&self, nodes: RNodesIn) -> Result<NodeVec>;
    fn parents(&self, nodes: RNodesIn) -> Result<NodeVec>;
    fn has_parents(&self, nodes: RNodesIn) -> Result<Vec<bool>>;
    fn has_children(&self, nodes: RNodesIn) -> Result<Vec<bool>>;
    fn least_common_parents(&self, selected: RNodesIn) -> Result<NodeVec>;
    fn get_all_leaves(&self) -> NodeVec;
    fn get_leaves_under(&self, nodes: RNodesIn) -> Result<NodeVec>;
    fn get_all_roots(&self) -> NodeVec;
    fn get_roots_over(&self, node_ids: RNodesIn) -> Result<NodeVec>;
    fn subset_multi(&self, node_id: RNodesIn) -> Result<Self>;
    fn subset_multi_with_limit(&self, node_id: RNodesIn, limit: i32) -> Result<Self>;
    fn print(&self) -> String;
    fn find_all_paths(&self, from: &str, to: &str) -> Result<List>;
    fn to_bin_disk(&self, path: &str) -> Result<()>;
    fn to_bin_mem(&self) -> Result<Vec<u8>>;
    fn from_bin_disk(path: &str) -> Result<Self>;
    fn from_bin_mem(bin: &[u8]) -> Result<Self>;
    fn nodes(&self) -> NodeVec;
    fn length(&self) -> i32;
    fn as_data_frame(&self) -> List;
    fn get_leaves_as_df(&self, nodes: RNodesIn) -> Result<Robj>;
}

impl_directed_graph!(DirectedAcyclicGraph, ow::DirectedAcyclicGraph);
impl_directed_graph!(DirectedGraph, ow::DirectedGraph);

// Macro to generate exports.
// This ensures exported functions are registered with R.
// See corresponding C code in `entrypoint.c`.
extendr_module! {
    mod orbweaver;
    impl DirectedGraph;
    impl DirectedAcyclicGraph;
    impl DirectedGraphBuilder;
    impl NodeVec;
    use from_dataframe;
}
