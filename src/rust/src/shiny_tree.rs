use extendr_api::prelude::*;
use std::collections::HashSet;

#[inline]
pub fn get_shinytree_selected(selected: Robj) -> HashSet<String> {
    // If it is selected return the name of the node and the
    // name of the children recursively.
    if let Ok(list) = List::try_from(selected) {
        return list
            .into_iter()
            .fold(HashSet::new(), |mut selection, (name, child)| {
                let is_selected: bool = child
                    .get_attrib("stselected")
                    .map(|x| x.try_into().unwrap_or_default())
                    .unwrap_or_default();
                if is_selected {
                    selection.insert(name.to_string());
                }
                let mut childnames = get_shinytree_selected(child);
                selection.extend(childnames);
                selection
            });
    }
    HashSet::new()
}
