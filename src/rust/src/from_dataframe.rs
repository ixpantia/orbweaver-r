use super::DirectedGraph;
use extendr_api::prelude::*;

#[extendr]
pub fn rs_populate_edges_directed_graph(
    graph: &mut DirectedGraph,
    dataframe: Robj,
    parent_col: &str,
    child_col: &str,
) -> Result<()> {
    let dataframe: List = dataframe.try_into().expect("Invalid data frame");
    let parents = dataframe
        .index(parent_col)
        .map_err(|_| format!("Column `{parent_col}` not found in data.frame"))?
        .as_str_iter()
        .ok_or_else(|| format!("Column `{parent_col}` is not of type `character`"))?;
    let children = dataframe
        .index(child_col)
        .map_err(|_| format!("Column `{child_col}` not found in data.frame"))?
        .as_str_iter()
        .ok_or_else(|| format!("Column `{child_col}` is not of type `character`"))?;

    // Iterate over the parents and children and add them to the graph.
    for (parent, child) in parents.zip(children) {
        graph.add_edge(parent, child)?;
    }

    Ok(())
}

#[extendr]
pub fn rs_populate_nodes_directed_graph(
    graph: &mut DirectedGraph,
    dataframe: Robj,
    node_id_col: &str,
    data_col: Nullable<&str>,
) -> Result<()> {
    let dataframe: List = dataframe.try_into().expect("Invalid data frame");
    let node_ids = dataframe
        .index(node_id_col)
        .map_err(|_| format!("Column `{node_id_col}` not found in data.frame"))?
        .as_str_iter()
        .ok_or_else(|| format!("Column `{node_id_col}` is not of type `character`"))?;
    let data_list = match data_col {
        NotNull(data_col) => dataframe
            .index(data_col)
            .map_err(|_| format!("Column `{data_col}` not found in data.frame"))?
            .as_list()
            .ok_or_else(|| format!("Unable to convert `{data_col}` into a list"))?,
        Null => List::new(node_ids.len()),
    };

    // Iterate over the parents and children and add them to the graph.
    for (node_id, (_, data)) in node_ids.zip(data_list) {
        graph.add_node(node_id, data)?;
    }

    Ok(())
}

extendr_module! {
    mod from_dataframe;
    fn rs_populate_edges_directed_graph;
    fn rs_populate_nodes_directed_graph;
}
