use super::DirectedGraphBuilder;
use extendr_api::prelude::*;

#[extendr]
pub fn rs_populate_edges_builder(
    graph: &mut DirectedGraphBuilder,
    parent_iter: Robj,
    child_iter: Robj,
) -> Result<()> {
    let parent_iter = StrIter::try_from(&parent_iter)?;
    let child_iter = StrIter::try_from(&child_iter)?;

    // Iterate over the parents and children and add them to the graph.
    for (parent, child) in parent_iter.zip(child_iter) {
        graph.add_edge(parent, child);
    }

    Ok(())
}

extendr_module! {
    mod from_dataframe;
    fn rs_populate_edges_builder;
}
