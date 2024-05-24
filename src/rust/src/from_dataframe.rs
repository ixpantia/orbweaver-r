use super::DirectedGraph;
use extendr_api::prelude::*;

#[extendr]
pub fn rs_populate_edges_directed_graph(
    graph: &mut DirectedGraph,
    parent_iter: StrIter,
    child_iter: StrIter,
) -> Result<()> {
    // Iterate over the parents and children and add them to the graph.
    for (parent, child) in parent_iter.zip(child_iter) {
        graph.add_edge(parent, child)?;
    }

    Ok(())
}

#[extendr]
pub fn rs_populate_nodes_directed_graph(
    graph: &mut DirectedGraph,
    node_ids: StrIter,
    data_iter: Nullable<List>,
) -> Result<()> {
    let data_iter = match data_iter {
        Null => List::new(node_ids.len()),
        NotNull(data_iter) => data_iter,
    };

    // Iterate over the parents and children and add them to the graph.
    for (node_id, (_, data)) in node_ids.zip(data_iter) {
        graph.add_node(node_id, data)?;
    }

    Ok(())
}

extendr_module! {
    mod from_dataframe;
    fn rs_populate_edges_directed_graph;
    fn rs_populate_nodes_directed_graph;
}
