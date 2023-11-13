use extendr_api::prelude::*;
use itertools::Itertools;
use std::collections::{HashMap, HashSet};
use std::rc::Rc;

#[derive(Debug, Clone)]
struct Node {
    id: Rc<str>,
    children: HashSet<Rc<str>>,
    parents: HashSet<Rc<str>>,
}

impl Node {
    fn new(id: Rc<str>) -> Self {
        Self {
            id,
            children: HashSet::new(),
            parents: HashSet::new(),
        }
    }
}

#[derive(IntoDataFrameRow)]
struct EdgesDFRow {
    parent: String,
    child: String,
}

/// Structure that holds the necessary information to build
/// a graph with no cycle (including trees).
#[derive(Debug, Clone)]
struct AcyclicGraph {
    nodes: HashMap<Rc<str>, Node>,
}

impl AcyclicGraph {
    /// Returns the parents of a node by name.
    fn parents(&self, node: &str) -> Vec<&str> {
        self.nodes
            .get(node)
            .map(|node| node.parents.iter().map(|parent| parent.as_ref()).collect())
            .unwrap_or_default()
    }
    /// Returns the children of a node by name.
    fn children(&self, node: &str) -> Vec<&str> {
        self.nodes
            .get(node)
            .map(|node| node.children.iter().map(|child| child.as_ref()).collect())
            .unwrap_or_default()
    }
    /// Internal function to build an R list from the graph.
    /// This function is recursive and should not be called directly.
    fn as_list_internal<'a>(&'a self, node: &'a str) -> (&str, Robj) {
        // We create a temporary hashmap to build the list.
        let mut temp_list = HashMap::new();
        // We get the children of the current node.
        let children = self.children(node);
        // If the children vector is empty, we return the current node and an R object
        // of type character with an empty string.
        if children.is_empty() {
            return (node, Robj::from(""));
        }
        // Otherwise we iterate over the children and recursively call the function.
        children.iter().for_each(|child| {
            // We get the name of the child and it's list.
            let (name, child_list) = self.as_list_internal(child);
            // We insert the child list into the temporary hashmap.
            temp_list.insert(name.to_string(), child_list);
        });
        // We convert the hashmap into an R list.
        let list = List::from_hashmap(temp_list).unwrap().into_robj();
        // We return the current node and the list.
        (node, list)
    }
    /// FindAllPaths
    fn internal_find_all_paths(&self, from: &str, to: &str) -> Vec<Vec<String>> {
        let mut all_paths = Vec::new();
        let path = vec![from.to_string()];
        self.dfs(from, to, path, &mut all_paths);
        all_paths
    }
    fn dfs(&self, from: &str, to: &str, mut path: Vec<String>, all_paths: &mut Vec<Vec<String>>) {
        if from == to {
            all_paths.push(path)
        } else {
            for child in self.children(from) {
                path.push(child.to_string());
                self.dfs(child, to, path.clone(), all_paths);
                path.pop();
            }
        }
    }
}

#[extendr]
impl AcyclicGraph {
    /// Creates a new graph with a root node.
    fn new() -> Self {
        let nodes = HashMap::new();
        Self { nodes }
    }
    /// Adds a node to the graph. If the node already exists, it does nothing.
    fn add_node(&mut self, node_id: &str) {
        let node_id: Rc<str> = node_id.into();
        self.nodes
            .entry(node_id.clone())
            .or_insert_with(|| Node::new(node_id));
    }
    /// Adds a child to a node.
    fn add_child(&mut self, parent_id: &str, child_id: &str) {
        self.add_node(parent_id);
        self.add_node(child_id);
        self.nodes
            .get_mut(parent_id)
            .expect("Parent not found")
            .children
            .insert(child_id.into());
        self.nodes
            .get_mut(child_id)
            .expect("Child not found")
            .parents
            .insert(parent_id.into());
    }
    /// Returns the children of a node.
    fn get_children(&self, node: &str) -> Vec<&str> {
        self.children(node)
    }
    /// Returns the parents of a node.
    fn get_parents(&self, node: &str) -> Vec<&str> {
        self.parents(node)
    }
    /// Returns the leaves of the graph.
    fn find_leaves(&self, node: &str) -> Vec<&str> {
        let node = self.nodes.get(node).unwrap();
        if node.children.is_empty() {
            return vec![node.id.as_ref()];
        }
        node.children
            .iter()
            .flat_map(|child| self.find_leaves(child))
            .unique()
            .collect()
    }
    /// Returns the least common parents of a set of nodes.
    fn find_least_common_parents(&self, selected: Vec<String>) -> Vec<&str> {
        let selected: HashSet<_> = selected.into_iter().collect();
        self.nodes
            .iter()
            .filter(|(id, _)| selected.contains(id.as_ref()))
            .filter(|(_, node)| {
                let contains_selected_parent = node
                    .parents
                    .iter()
                    .any(|parent| selected.contains(parent.as_ref()));
                !contains_selected_parent
            })
            .map(|(id, _)| id.as_ref())
            .unique()
            .collect()
    }
    /// Gets the root of the graph.
    fn find_roots(&self) -> Vec<&str> {
        self.nodes
            .iter()
            .filter(|(_, node)| node.parents.is_empty())
            .map(|(id, _)| id.as_ref())
            .unique()
            .collect()
    }
    /// Returns the graph as an R list. (Useful for libraries like `shinyTree`).
    fn as_list(&self) -> Robj {
        let list = self
            .nodes
            .iter()
            .filter(|(_, node)| node.parents.is_empty())
            .map(|(id, _)| self.as_list_internal(id))
            .collect::<Vec<_>>();
        List::from_pairs(list).into_robj()
    }
    /// Creates an acyclic graph from a data frame.
    fn from_dataframe(dataframe: Robj) -> Self {
        let dataframe: Dataframe<EdgesDFRow> = dataframe.try_into().expect("Invalid data frame");
        let mut graph = Self::new();
        let parents = dataframe
            .index("parent")
            .expect("Column 'parent' not found");
        let parents = parents.as_str_vector().expect("Invalid parent column");
        let children = dataframe.index("child").expect("Column 'child' not found");
        let children = children.as_str_vector().expect("Invalid child column");
        // Iterate over the parents and children and add them to the graph.
        parents
            .iter()
            .zip(children)
            .for_each(|(parent, child)| graph.add_child(parent, child));
        graph
    }
    /// Creates a new copy of the graph.
    fn graph_clone(&self) -> Self {
        self.clone()
    }
    /// Search for similarly named nodes.
    fn search_for_node(&self, node_id: &str, case_sensitive: bool) -> Vec<&str> {
        self.nodes
            .keys()
            .filter(|id| {
                if case_sensitive {
                    id.contains(node_id)
                } else {
                    id.to_lowercase().contains(&node_id.to_lowercase())
                }
            })
            .map(|id| id.as_ref())
            .sorted_by_key(|id| id.len())
            .collect()
    }
    /// find_all_paths
    fn find_all_paths(&self, from: &str, to: &str) -> List {
        let paths = self.internal_find_all_paths(from, to).into_iter();
        List::from_iter(paths)
    }
}

extendr_module! {
    mod orbweaver;
    impl AcyclicGraph;
}
