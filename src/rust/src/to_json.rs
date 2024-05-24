use super::{to_r_error, DirectedAcyclicGraph, DirectedGraph};
use extendr_api::prelude::*;
use orbweaver::prelude as ow;

#[extendr]
fn rs_directed_graph_to_json(directed_graph: &DirectedGraph, pretty: bool) -> Result<String> {
    if pretty {
        Ok(serde_json::to_string_pretty(&directed_graph.0).map_err(to_r_error)?)
    } else {
        Ok(serde_json::to_string(&directed_graph.0).map_err(to_r_error)?)
    }
}

#[extendr]
fn rs_directed_graph_from_json(text: &str) -> Result<DirectedGraph> {
    let dg: ow::DirectedGraph<Robj> = serde_json::from_str(text).map_err(|e| e.to_string())?;
    Ok(DirectedGraph(dg))
}

#[extendr]
fn rs_dag_to_json(dag: &DirectedAcyclicGraph, pretty: bool) -> Result<String> {
    if pretty {
        Ok(serde_json::to_string_pretty(&dag.0).map_err(to_r_error)?)
    } else {
        Ok(serde_json::to_string(&dag.0).map_err(to_r_error)?)
    }
}

#[extendr]
fn rs_dag_from_json(text: &str) -> Result<DirectedAcyclicGraph> {
    let dag: ow::DirectedAcyclicGraph<Robj> =
        serde_json::from_str(text).map_err(|e| e.to_string())?;
    Ok(DirectedAcyclicGraph(dag))
}

extendr_module! {
    mod to_json;
    fn rs_directed_graph_from_json;
    fn rs_directed_graph_to_json;
    fn rs_dag_to_json;
    fn rs_dag_from_json;
}
