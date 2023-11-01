use extendr_api::prelude::*;
use std::cell::RefCell;
use std::collections::{HashMap, HashSet};
use std::rc::Rc;

struct AcyclicGraph {
    nodes: HashSet<Rc<str>>,
    parents: HashMap<Rc<str>, Vec<Rc<str>>>,
    children: HashMap<Rc<str>, Vec<Rc<str>>>,
    root: Rc<str>,
}

impl AcyclicGraph {
    fn parents(&self, node: &str) -> &[Rc<str>] {
        let node = self.nodes.get(node).unwrap();
        self.parents
            .get(node)
            .map(|parents| parents.as_slice())
            .unwrap_or_default()
    }
    fn children(&self, node: &str) -> &[Rc<str>] {
        let node = self.nodes.get(node).unwrap();
        self.children
            .get(node)
            .map(|children| children.as_slice())
            .unwrap_or_default()
    }
    fn as_list_internal<'a>(&'a self, node: &'a str) -> (&str, Robj) {
        let mut temp_list = HashMap::new();
        let children = self.children(node);
        if children.is_empty() {
            return (node, Robj::from(""));
        }
        children.iter().for_each(|child| {
            let (name, child_list) = self.as_list_internal(child);
            temp_list.insert(name.to_string(), child_list);
        });
        let list = List::from_hashmap(temp_list).unwrap().into_robj();
        (node, list)
    }
}

/// @export
#[extendr]
impl AcyclicGraph {
    fn new(root: &str) -> Self {
        let root: Rc<str> = root.into();
        let mut nodes = HashSet::new();
        nodes.insert(root.clone());
        Self {
            nodes,
            parents: HashMap::new(),
            children: HashMap::new(),
            root,
        }
    }
    fn add_node(&mut self, node: &str) {
        self.nodes.insert(node.into());
    }
    fn add_child(&mut self, node: &str, child: &str) {
        let node = self.nodes.get(node).unwrap();
        let child = self.nodes.get(child).unwrap();
        self.children
            .entry(node.clone())
            .or_default()
            .push(child.clone());
        self.parents
            .entry(child.clone())
            .or_default()
            .push(node.clone());
    }
    fn get_children(&self, node: &str) -> Vec<&str> {
        self.children(node)
            .iter()
            .map(|child| child.as_ref())
            .collect()
    }
    fn get_parents(&self, node: &str) -> Vec<&str> {
        self.parents(node)
            .iter()
            .map(|parent| parent.as_ref())
            .collect()
    }
    fn find_leaves(&self, node: &str) -> Vec<&str> {
        let node = self.nodes.get(node).unwrap();
        match self.children.get(node) {
            None => vec![node.as_ref()],
            Some(children) => children
                .iter()
                .flat_map(|child| self.find_leaves(child))
                .collect(),
        }
    }
    fn find_least_common_parents(&self, selected: Vec<String>) -> Vec<&str> {
        let selected: HashSet<_> = selected.into_iter().collect();
        if selected.contains(self.root.as_ref()) {
            return vec![self.root.as_ref()];
        }
        self.nodes
            .iter()
            .filter(|node| selected.contains(node.as_ref()))
            .filter(|node| {
                let contains_selected_parent = self
                    .parents(node)
                    .iter()
                    .any(|parent| selected.contains(parent.as_ref()));
                let self_in_selected = selected.contains(node.as_ref());
                !contains_selected_parent && self_in_selected
            })
            .map(|node| node.as_ref())
            .collect()
    }
    fn as_list(&self) -> Robj {
        let list = self.as_list_internal(self.root.as_ref());
        List::from_pairs([list]).into_robj()
    }
}

extendr_module! {
    mod noder;
    impl AcyclicGraph;
}
