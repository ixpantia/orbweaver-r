throw_if_error <- function(res) {
  if (methods::is(res, "error")) rlang::abort(res$value)
  return(res)
}
