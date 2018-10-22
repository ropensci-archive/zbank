#' Matching taxon name service
#'
#' @export
#' @param id (integer/numeric) Any ZooBank identifier, for taxon, author
#' or publication. required
#' @template all
#' @examples \dontrun{
#' zb_matching(id = "FFF7160A-372D-40E9-9611-23AF5D9EAC4C")
#' }
zb_matching <- function(id, parse = TRUE, ...) {
  assert_is(parse, 'logical')
  out <- zb_matching_(id, ...)
  tmp <- jsonlite::fromJSON(out, parse)
  if (parse) {
    df <- tibble::as_tibble(do.call(data.frame, 
      c(tmp$DATA, stringsAsFactors = FALSE)))
    names(df) <- tolower(names(df))
    return(df)
  } else {
    return(tmp)
  }
}

#' @export
#' @rdname zb_id
zb_matching_ <- function(id, ...) {
  assert_is(id, 'character')
  zb_GET(file.path("MatchingTaxonNames.json", id), list(), ...)
}
