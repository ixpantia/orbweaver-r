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
