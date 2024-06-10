#[macro_export]
macro_rules! impl_directed_graph {
    () => {
        fn find_path(&self, from: &str, to: &str) -> Result<Vec<String>> {
            Ok(self
                .0
                .find_path(from, to)
                .map_err(to_r_error)?
                .into_iter()
                .map(String::from)
                .collect())
        }
        fn children(&self, nodes: Strings) -> Vec<String> {
            self.0
                .children(nodes.iter())
                .map(|children| children.into_iter().map(String::from).collect())
                .unwrap_or_default()
        }
        fn parents(&self, nodes: Strings) -> Vec<String> {
            self.0
                .parents(nodes.iter())
                .map(|children| children.into_iter().map(String::from).collect())
                .unwrap_or_default()
        }
        fn has_parents(&self, nodes: Strings) -> Result<Vec<bool>> {
            self.0.has_parents(nodes.iter()).map_err(to_r_error)
        }
        fn has_children(&self, nodes: Strings) -> Result<Vec<bool>> {
            self.0.has_children(nodes.iter()).map_err(to_r_error)
        }
        fn least_common_parents(&self, selected: Strings) -> Result<Vec<String>> {
            Ok(self
                .0
                .least_common_parents(selected.iter())
                .map_err(to_r_error)?
                .into_iter()
                .map(String::from)
                .collect())
        }
        fn get_all_leaves(&self) -> Vec<String> {
            self.0
                .get_all_leaves()
                .into_iter()
                .map(String::from)
                .collect()
        }
        fn get_leaves_under(&self, nodes: Strings) -> Result<Vec<String>> {
            Ok(self
                .0
                .get_leaves_under(nodes.iter())
                .map_err(to_r_error)?
                .into_iter()
                .map(String::from)
                .collect())
        }
        fn get_all_roots(&self) -> Vec<String> {
            self.0
                .get_all_roots()
                .into_iter()
                .map(String::from)
                .collect()
        }
        fn get_roots_over(&self, node_ids: Vec<String>) -> Result<Vec<String>> {
            Ok(self
                .0
                .get_roots_over(&node_ids)
                .map_err(to_r_error)?
                .into_iter()
                .map(String::from)
                .collect())
        }
        fn subset(&self, node_id: &str) -> Result<Self> {
            Ok(Self(self.0.subset(node_id).map_err(to_r_error)?))
        }
        fn print(&self) {
            println!("{:?}", self.0)
        }
    };
}
