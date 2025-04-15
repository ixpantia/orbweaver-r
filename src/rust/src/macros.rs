#[macro_export]
macro_rules! impl_directed_graph {
    ($ty:ident, $inner:ty) => {
        #[extendr]
        impl RImplDirectedGraph for $ty {
            fn find_path(&self, from: &str, to: &str) -> Result<NodeVec> {
                self.0.find_path(from, to).map_err(to_r_error).map(NodeVec)
            }
            fn children(&self, nodes: RNodesIn) -> Result<NodeVec> {
                self.0
                    .children(nodes.iter())
                    .map(NodeVec)
                    .map_err(to_r_error)
            }
            fn parents(&self, nodes: RNodesIn) -> Result<NodeVec> {
                self.0
                    .parents(nodes.iter())
                    .map_err(to_r_error)
                    .map(NodeVec)
            }
            fn has_parents(&self, nodes: RNodesIn) -> Result<Vec<bool>> {
                self.0.has_parents(nodes.iter()).map_err(to_r_error)
            }
            fn has_children(&self, nodes: RNodesIn) -> Result<Vec<bool>> {
                self.0.has_children(nodes.iter()).map_err(to_r_error)
            }
            fn least_common_parents(&self, selected: RNodesIn) -> Result<NodeVec> {
                self.0
                    .least_common_parents(selected.iter())
                    .map_err(to_r_error)
                    .map(NodeVec)
            }
            fn get_all_leaves(&self) -> NodeVec {
                self.0.get_all_leaves().into()
            }
            fn get_leaves_under(&self, nodes: RNodesIn) -> Result<NodeVec> {
                self.0
                    .get_leaves_under(nodes.iter())
                    .map_err(to_r_error)
                    .map(NodeVec)
            }
            fn get_all_roots(&self) -> NodeVec {
                self.0.get_all_roots().into()
            }
            fn get_roots_over(&self, node_ids: RNodesIn) -> Result<NodeVec> {
                self.0
                    .get_roots_over(node_ids.iter())
                    .map_err(to_r_error)
                    .map(NodeVec)
            }
            fn subset_multi(&self, node_ids: RNodesIn) -> Result<Self> {
                Ok(Self(
                    self.0.subset_multi(node_ids.iter()).map_err(to_r_error)?,
                ))
            }
            fn subset_multi_with_limit(&self, node_ids: RNodesIn, limit: i32) -> Result<Self> {
                if limit <= 0 {
                    return Err("Limit cannot be negative".into());
                }

                // This is safe because we checked right before
                let limit = unsafe { std::num::NonZeroUsize::new_unchecked(limit as usize) };

                Ok(Self(
                    self.0
                        .subset_multi_with_limit(node_ids.iter(), limit)
                        .map_err(to_r_error)?,
                ))
            }
            fn print(&self) -> String {
                format!("{:?}", self.0)
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
                <$inner>::from_binary(file).map($ty).map_err(to_r_error)
            }

            fn from_bin_mem(bin: &[u8]) -> Result<Self> {
                <$inner>::from_binary(bin).map($ty).map_err(to_r_error)
            }

            fn nodes(&self) -> NodeVec {
                self.0.nodes().into()
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
                    .map(NodeVec)
                    .collect())
            }

            fn find_path_one_to_many(&self, from: &str, to: Strings) -> Result<List> {
                Ok(self
                    .0
                    .find_path_one_to_many(from, to.iter())
                    .map_err(to_r_error)?
                    .into_iter()
                    .map(NodeVec)
                    .collect())
            }

            fn as_data_frame(&self) -> List {
                let internal_graph = &self.0;

                let n_nodes = internal_graph.nodes().len();
                let mut from = Vec::with_capacity(n_nodes);
                let mut to = Vec::with_capacity(n_nodes);

                for node in &internal_graph.nodes() {
                    let children = internal_graph
                        .children([node])
                        .expect("Every node is valid");

                    let mut children = children.as_vec();

                    children.dedup();

                    let node = Rstr::from(node);

                    for child in children {
                        from.push(node.clone());
                        to.push(Rstr::from(child));
                    }
                }

                list!(from = from, to = to)
            }

            fn get_leaves_as_df(&self, nodes: RNodesIn) -> Result<Robj> {
                let mut parent = Vec::new();
                let mut leaves = Vec::new();
                for node in nodes.iter() {
                    if let Ok(node_leaves) = self.as_inner().get_leaves_under([node]) {
                        if node_leaves.is_empty() {
                            parent.push(Rstr::from_string(node));
                            leaves.push(Rstr::from_string(node));
                            continue;
                        }
                        let len = node_leaves.len();
                        parent.extend(std::iter::repeat(Rstr::from_string(node)).take(len));
                        leaves.extend(node_leaves.iter().map(Rstr::from_string));
                    }
                }
                Ok(data_frame!(parent = parent, leaves = leaves))
            }
        }

        impl $ty {
            pub fn as_inner(&self) -> &$inner {
                &self.0
            }
            pub fn as_inner_mut(&mut self) -> &mut $inner {
                &mut self.0
            }
            pub fn into_inner(self) -> $inner {
                self.0
            }
            pub fn from_inner(inner: $inner) -> Self {
                Self(inner)
            }
        }
    };
}
