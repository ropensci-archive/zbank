#' Name usages
#'
#' @export
#' @param name (character) A taxonomic name
#' @param id (integer/numeric) A taxonomic identifier
#' @param query (character) A taxonomic name to query
#' @template all
#' @examples \dontrun{
#' zb_name_usages(name = "Pseudanthias carlsoni")
#' zb_name_usages(id = "6EA8BB2A-A57B-47C1-953E-042D8CD8E0E2")
#' zb_name_usages(query = "pyle")
#' }
zb_name_usages <- function(name = NULL, id = NULL, query = NULL, 
    parse = TRUE, ...) {

  assert_is(parse, 'logical')
  zb_parse(zb_name_usages_(name, id, query, ...), parse)
}

#' @export
#' @rdname zb_name_usages
zb_name_usages_ <- function(name = NULL, id = NULL, query = NULL, ...) {
  assert_is(name, 'character')
  if (!is.null(name)) name <- gsub("\\s", "_", name)
  assert_is(id, 'character')
  assert_is(query, 'character')
  
  if ((!is.null(name) || !is.null(id)) && is.null(query)) {
    stopifnot(xor(!is.null(name), !is.null(id)))
    path <- file.path("NomenclaturalActs.json", c(name, id))
    args <- list()
  } else {
    path <- "NomenclaturalActs.json"
    args <- list(search_term = query)
  }
  zb_GET(path, args, ...)
}
