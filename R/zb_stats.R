#' Get statistics on Zoobank activity
#'
#' @export
#' @param start_date (date/character) a start date
#' @param end_date (date/character) an end date
#' @param period (character) the period. Default: day
#' @template all
#' @examples \dontrun{
#' zb_stats(start_date = "2018-03-01", end_date = "2018-04-01")
#' zb_stats(start_date = "2018-03-01", end_date = "2018-04-01", 
#'  parse = FALSE)
#' }
zb_stats <- function(start_date, end_date, period = "day", parse = TRUE, ...) {
  assert_is(parse, 'logical')
  out <- zb_stats_(start_date, end_date, period, ...)
  tmp <- jsonlite::fromJSON(out, parse)
  if (parse) {
    stats::setNames(tibble::as_tibble(tmp$data), tolower(tmp$columns))
  } else {
    tmp
  }
}

#' @export
#' @rdname zb_stats
zb_stats_ <- function(start_date, end_date, period, ...) {
  assert_is(start_date, c('Date', 'character'))
  assert_is(end_date, c('Date', 'character'))
  assert_is(period, 'character')

  args <- ct(list(start_date = start_date, end_date = end_date, 
    period = period))
  zb_GET("Statistics.json", args, ...)
}
