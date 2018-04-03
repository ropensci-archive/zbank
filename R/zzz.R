ct <- function(l) Filter(Negate(is.null), l)

zbank_ua <- function() {
  versions <- c(
    paste0("r-curl/", utils::packageVersion("curl")),
    paste0("crul/", utils::packageVersion("crul")),
    sprintf("rOpenSci(zbank/%s)", utils::packageVersion("zbank"))
  )
  paste0(versions, collapse = " ")
}

zb_GET <- function(path, args, ...){
  cli <- crul::HttpClient$new(
    url = file.path(zb_base(), path),
    opts = list(useragent = zbank_ua())
  )
  temp <- cli$get(query = args, ...)
  temp$raise_for_status()
  x <- temp$parse("UTF-8")
  return(x)
}

zb_parse <- function(x, parse) {
  tmp <- jsonlite::fromJSON(x, parse)
  if (parse) {
    df <- tibble::as_tibble(tmp) 
    names(df) <- tolower(names(df))
    return(df)
  } else {
    return(tmp)
  }
}

zb_base <- function() "http://zoobank.org"

space <- function(x) gsub("\\s", "%20", x)

assert_is <- function(x, y) {
  if (!is.null(x)) {
    if (!class(x) %in% y) {
      stop(deparse(substitute(x)), " must be of class ",
           paste0(y, collapse = ", "), call. = FALSE)
    }
  }
}

assert_n <- function(x, n) {
  if (!is.null(x)) {
    if (!length(x) == n) {
      stop(deparse(substitute(x)), " must be length ", n, call. = FALSE)
    }
  }
}

zb_bind <- function(x) {
  tibble::as_tibble(do.call("rbind.data.frame", x))
}
