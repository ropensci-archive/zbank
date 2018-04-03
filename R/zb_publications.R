#' Publications
#'
#' @export
#' @param id (integer/numeric) A publication identifier
#' @param query (character) Query terms
#' @template all
#' @examples \dontrun{
#' zb_publications(id = "427D7953-E8FC-41E8-BEA7-8AE644E6DE77")
#' zb_publications(query = "pyle")
#' }
zb_publications <- function(id = NULL, query = NULL, parse = TRUE, ...) {
  assert_is(parse, 'logical')
  zb_parse(zb_publications_(id, query, ...), parse)
}

#' @export
#' @rdname zb_publications
zb_publications_ <- function(id, query, ...) {
  assert_is(id, 'character')
  assert_is(query, 'character')
  
  if (!is.null(id) && is.null(query)) {
    path <- file.path("References.json", id)
    args <- list()
  } else {
    path <- "References.json"
    args <- list(search_term = query)
  }
  zb_GET(path, args, ...)
}
