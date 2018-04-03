#' Get data by identifier
#'
#' @export
#' @param id (integer/numeric) Any ZooBank identifier, for taxon, author
#' or publication. required
#' @template all
#' @examples \dontrun{
#' zb_id(id = "6EA8BB2A-A57B-47C1-953E-042D8CD8E0E2")
#' }
zb_id <- function(id, parse = TRUE, ...) {
  assert_is(parse, 'logical')
  zb_parse(zb_id_(id, ...), parse)
}

#' @export
#' @rdname zb_id
zb_id_ <- function(id, ...) {
  assert_is(id, 'character')
  zb_GET(file.path("Identifiers.json", id), list(), ...)
}
