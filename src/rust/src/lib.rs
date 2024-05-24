use extendr_api::prelude::*;
use orbweaver::prelude as ow;

pub mod from_dataframe;

struct Node(ow::Node<Robj>);

impl From<ow::Node<Robj>> for Node {
    fn from(value: ow::Node<Robj>) -> Self {
        Node(value)
    }
}

#[extendr]
impl Node {
    fn get_data(&self) -> Robj {
        self.0.data().clone()
    }
    fn set_data(&mut self, data: Robj) {
        *self.0.data_mut() = data;
    }
}

pub struct DirectedGraph(ow::DirectedGraph<Robj>);
pub struct DirectedAcyclicGraph(ow::DirectedAcyclicGraph<Robj>);

fn to_r_error(err: impl std::error::Error) -> String {
    err.to_string()
}

#[extendr]
impl DirectedGraph {
    fn new() -> Self {
        DirectedGraph(ow::DirectedGraph::new())
    }

    fn add_node(&mut self, node_id: &str, data: Robj) -> Result<()> {
        self.0.add_node(node_id, data).map_err(to_r_error)?;
        Ok(())
    }

    fn get_node(&self, node_id: &str) -> Result<Node> {
        Ok(self
            .0
            .get_node(node_id)
            .map_err(to_r_error)?
            .cloned()
            .into())
    }

    pub fn get_nodes(&self, ids: StrIter) -> Result<List> {
        Ok(self
            .0
            .get_nodes(ids)
            .map_err(to_r_error)?
            .into_iter()
            .map(ow::Node::cloned)
            .map(Node::from)
            .collect())
    }

    pub fn add_edge(&mut self, from: &str, to: &str) -> Result<()> {
        self.0.add_edge(from, to).map_err(to_r_error)?;
        Ok(())
    }

    pub fn add_path(&mut self, path: StrIter) -> Result<()> {
        let path: Vec<&str> = path.collect();
        self.0.add_path(&path).map_err(to_r_error)?;
        Ok(())
    }

    pub fn edge_exists(&self, from: &str, to: &str) -> bool {
        self.0.edge_exists(from, to)
    }

    pub fn deep_clone(&self) -> Self {
        DirectedGraph(self.0.clone())
    }

    pub fn find_path(&self, from: &str, to: &str) -> Result<Vec<String>> {
        Ok(self
            .0
            .find_path(from, to)
            .map_err(to_r_error)?
            .map(|path| path.into_iter().map(String::from).collect())
            .unwrap_or_default())
    }

    pub fn children(&self, node: &str) -> Vec<String> {
        self.0
            .children(node)
            .map(|children| children.iter().map(String::from).collect())
            .unwrap_or_default()
    }

    pub fn parents(&self, node: &str) -> Vec<String> {
        self.0
            .parents(node)
            .map(|parents| {
                parents
                    .iter()
                    .map(ow::NodeId::as_ref)
                    .map(String::from)
                    .collect()
            })
            .unwrap_or_default()
    }

    pub fn remove_edge(&mut self, from: &str, to: &str) {
        self.0.remove_edge(from, to);
    }

    pub fn remove_node(&mut self, node_id: &str) {
        self.0.remove_node(node_id);
    }

    pub fn has_parents(&self, node_id: &str) -> Result<bool> {
        Ok(self.0.has_parents(node_id).map_err(to_r_error)?)
    }

    pub fn has_children(&self, node_id: &str) -> Result<bool> {
        Ok(self.0.has_children(node_id).map_err(to_r_error)?)
    }

    pub fn nodes(&self) -> Vec<String> {
        self.0.node_ids().map(String::from).collect()
    }

    pub fn least_common_parents(&self, selected: Vec<String>) -> Result<Vec<String>> {
        Ok(self
            .0
            .least_common_parents(&selected)
            .map_err(to_r_error)?
            .into_iter()
            .map(String::from)
            .collect())
    }

    pub fn get_leaves(&self) -> Vec<String> {
        self.0.get_leaves().into_iter().map(String::from).collect()
    }

    pub fn get_leaves_under(&self, node_ids: Vec<String>) -> Result<Vec<String>> {
        Ok(self
            .0
            .get_leaves_under(node_ids.as_slice())
            .map_err(to_r_error)?
            .into_iter()
            .map(String::from)
            .collect())
    }

    pub fn clear_edges(&mut self) {
        self.0.clear_edges();
    }

    #[allow(clippy::wrong_self_convention)]
    pub fn into_dag(&self) -> Result<DirectedAcyclicGraph> {
        Ok(DirectedAcyclicGraph(
            ow::DirectedAcyclicGraph::build(self.0.clone()).map_err(to_r_error)?,
        ))
    }
}

#[extendr]
impl DirectedAcyclicGraph {
    fn get_node(&self, node_id: &str) -> Result<Node> {
        Ok(self
            .0
            .get_node(node_id)
            .map_err(to_r_error)?
            .cloned()
            .into())
    }

    pub fn get_nodes(&self, ids: StrIter) -> Result<List> {
        Ok(self
            .0
            .get_nodes(ids)
            .map_err(to_r_error)?
            .into_iter()
            .map(ow::Node::cloned)
            .map(Node::from)
            .collect())
    }

    pub fn edge_exists(&self, from: &str, to: &str) -> bool {
        self.0.edge_exists(from, to)
    }

    pub fn deep_clone(&self) -> Self {
        DirectedAcyclicGraph(self.0.clone())
    }

    pub fn find_path(&self, from: &str, to: &str) -> Result<Vec<String>> {
        Ok(self
            .0
            .find_path(from, to)
            .map_err(to_r_error)?
            .map(|path| path.into_iter().map(String::from).collect())
            .unwrap_or_default())
    }

    pub fn find_all_paths(&self, from: &str, to: &str) -> Result<List> {
        Ok(self
            .0
            .find_all_paths(from, to)
            .map_err(to_r_error)?
            .into_iter()
            .map(|path| path.into_iter().map(String::from).collect::<Vec<_>>())
            .collect::<List>())
    }

    pub fn children(&self, node: &str) -> Vec<String> {
        self.0
            .children(node)
            .map(|children| children.iter().map(String::from).collect())
            .unwrap_or_default()
    }

    pub fn parents(&self, node: &str) -> Vec<String> {
        self.0
            .parents(node)
            .map(|parents| {
                parents
                    .iter()
                    .map(ow::NodeId::as_ref)
                    .map(String::from)
                    .collect()
            })
            .unwrap_or_default()
    }

    pub fn has_parents(&self, node_id: &str) -> Result<bool> {
        Ok(self.0.has_parents(node_id).map_err(to_r_error)?)
    }

    pub fn has_children(&self, node_id: &str) -> Result<bool> {
        Ok(self.0.has_children(node_id).map_err(to_r_error)?)
    }

    pub fn nodes(&self) -> Vec<String> {
        self.0.node_ids().map(String::from).collect()
    }

    pub fn least_common_parents(&self, selected: Vec<String>) -> Result<Vec<String>> {
        Ok(self
            .0
            .least_common_parents(&selected)
            .map_err(to_r_error)?
            .into_iter()
            .map(String::from)
            .collect())
    }

    pub fn get_leaves(&self) -> Vec<String> {
        self.0.get_leaves().into_iter().map(String::from).collect()
    }

    pub fn get_leaves_under(&self, node_ids: Vec<String>) -> Result<Vec<String>> {
        Ok(self
            .0
            .get_leaves_under(node_ids.as_slice())
            .map_err(to_r_error)?
            .into_iter()
            .map(String::from)
            .collect())
    }

    #[allow(clippy::wrong_self_convention)]
    pub fn into_directed(&self) -> DirectedGraph {
        DirectedGraph(self.0.clone().into_inner())
    }
}

// Macro to generate exports.
// This ensures exported functions are registered with R.
// See corresponding C code in `entrypoint.c`.
extendr_module! {
    mod orbweaver;
    impl Node;
    impl DirectedGraph;
    impl DirectedAcyclicGraph;
    use from_dataframe;
}
