use extendr_api::prelude::*;
use orbweaver::prelude as ow;

pub mod from_dataframe;
pub mod to_json;

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

#[extendr]
impl DirectedGraph {
    pub fn find_path(&self, from: &str, to: &str) -> Result<Vec<String>> {
        Ok(self
            .0
            .find_path(from, to)
            .map_err(to_r_error)?
            .into_iter()
            .map(String::from)
            .collect())
    }

    pub fn children(&self, nodes: Strings) -> Vec<String> {
        self.0
            .children(nodes.into_iter())
            .map(|children| children.into_iter().map(String::from).collect())
            .unwrap_or_default()
    }

    pub fn parents(&self, nodes: Strings) -> Vec<String> {
        self.0
            .parents(nodes.into_iter())
            .map(|children| children.into_iter().map(String::from).collect())
            .unwrap_or_default()
    }

    pub fn has_parents(&self, nodes: Strings) -> Result<Vec<bool>> {
        self.0.has_parents(nodes.into_iter()).map_err(to_r_error)
    }

    pub fn has_children(&self, nodes: Strings) -> Result<Vec<bool>> {
        self.0.has_children(nodes.into_iter()).map_err(to_r_error)
    }

    pub fn least_common_parents(&self, selected: Strings) -> Result<Vec<String>> {
        Ok(self
            .0
            .least_common_parents(selected.into_iter())
            .map_err(to_r_error)?
            .into_iter()
            .map(String::from)
            .collect())
    }

    pub fn get_all_leaves(&self) -> Vec<String> {
        self.0
            .get_all_leaves()
            .into_iter()
            .map(String::from)
            .collect()
    }

    pub fn get_leaves_under(&self, nodes: Strings) -> Result<Vec<String>> {
        Ok(self
            .0
            .get_leaves_under(nodes.into_iter())
            .map_err(to_r_error)?
            .into_iter()
            .map(String::from)
            .collect())
    }

    pub fn get_all_roots(&self) -> Vec<String> {
        self.0
            .get_all_roots()
            .into_iter()
            .map(String::from)
            .collect()
    }

    pub fn get_roots_over(&self, node_ids: Vec<String>) -> Result<Vec<String>> {
        Ok(self
            .0
            .get_roots_over(&node_ids)
            .map_err(to_r_error)?
            .into_iter()
            .map(String::from)
            .collect())
    }

    pub fn subset(&self, node_id: &str) -> Result<Self> {
        Ok(Self(self.0.subset(node_id).map_err(to_r_error)?))
    }

    fn print(&self) {
        println!("{:?}", self.0)
    }
}

#[extendr]
impl DirectedAcyclicGraph {
    pub fn find_path(&self, from: &str, to: &str) -> Result<Vec<String>> {
        Ok(self
            .0
            .find_path(from, to)
            .map_err(to_r_error)?
            .into_iter()
            .map(String::from)
            .collect())
    }

    pub fn children(&self, nodes: Strings) -> Vec<String> {
        self.0
            .children(nodes.into_iter())
            .map(|children| children.into_iter().map(String::from).collect())
            .unwrap_or_default()
    }

    pub fn parents(&self, nodes: Strings) -> Vec<String> {
        self.0
            .parents(nodes.into_iter())
            .map(|children| children.into_iter().map(String::from).collect())
            .unwrap_or_default()
    }

    pub fn has_parents(&self, nodes: Strings) -> Result<Vec<bool>> {
        self.0.has_parents(nodes.into_iter()).map_err(to_r_error)
    }

    pub fn has_children(&self, nodes: Strings) -> Result<Vec<bool>> {
        self.0.has_children(nodes.into_iter()).map_err(to_r_error)
    }

    pub fn least_common_parents(&self, selected: Strings) -> Result<Vec<String>> {
        Ok(self
            .0
            .least_common_parents(selected.into_iter())
            .map_err(to_r_error)?
            .into_iter()
            .map(String::from)
            .collect())
    }

    pub fn get_all_leaves(&self) -> Vec<String> {
        self.0
            .get_all_leaves()
            .into_iter()
            .map(String::from)
            .collect()
    }

    pub fn get_leaves_under(&self, nodes: Strings) -> Result<Vec<String>> {
        Ok(self
            .0
            .get_leaves_under(nodes.into_iter())
            .map_err(to_r_error)?
            .into_iter()
            .map(String::from)
            .collect())
    }

    pub fn get_all_roots(&self) -> Vec<String> {
        self.0
            .get_all_roots()
            .into_iter()
            .map(String::from)
            .collect()
    }

    pub fn get_roots_over(&self, node_ids: Vec<String>) -> Result<Vec<String>> {
        Ok(self
            .0
            .get_roots_over(&node_ids)
            .map_err(to_r_error)?
            .into_iter()
            .map(String::from)
            .collect())
    }

    pub fn subset(&self, node_id: &str) -> Result<Self> {
        Ok(Self(self.0.subset(node_id).map_err(to_r_error)?))
    }

    pub fn find_all_paths(&self, from: &str, to: &str) -> Result<List> {
        Ok(self
            .0
            .find_all_paths(from, to)
            .map_err(to_r_error)?
            .into_iter()
            .collect())
    }

    fn print(&self) {
        println!("{:?}", self.0)
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
    use to_json;
}
