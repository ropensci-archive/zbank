# set up vcr
library("vcr")
invisible(
  vcr::vcr_configure(
    dir = "../fixtures",
    preserve_exact_body_bytes = FALSE
  )
)
