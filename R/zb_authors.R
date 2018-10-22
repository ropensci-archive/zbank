#' Search for authors
#'
#' @export
#' @param id (integer/numeric) An author identifier
#' @param query (character) Query terms
#' @template all
#' @examples \dontrun{
#' zb_authors(id = "8C466CBE-3F7D-4DC9-8CBD-26DD3F57E212")
#' zb_authors(query = "Schmutz")
#' zb_authors(query = "Pyle")
#' }
zb_authors <- function(id = NULL, query = NULL, parse = TRUE, ...) {
  assert_is(parse, 'logical')
  zb_parse(zb_authors_(id, query, ...), parse)
}

#' @export
#' @rdname zb_authors
zb_authors_ <- function(id = NULL, query = NULL, ...) {
  assert_is(id, 'character')
  assert_is(query, 'character')
  
  if (!is.null(id) && is.null(query)) {
    path <- file.path("Authors.json", id)
    args <- list()
  } else {
    path <- "Authors.json"
    args <- list(term = query)
  }
  zb_GET(path, args, ...)
}
