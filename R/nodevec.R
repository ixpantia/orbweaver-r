#' @export
print.NodeVec <- function(x, ...) {
  writeLines(x$print())
}

#' @export
as.character.NodeVec <- function(x, ...) {
  x$as_character()
}

#' @export
length.NodeVec <- function(x, ...) {
  x$len()
}
