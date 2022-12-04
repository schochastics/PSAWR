make_get_request <- function(path,params,FUN){
  url <- httr::parse_url("")
  url$hostname <- "api.pushshift.io"
  url$scheme <- "https"
  resp <- httr::GET(httr::modify_url(url,path = path),query=params)
  cont <- httr::content(resp)
  FUN(cont$data)
}

to_epoch <- function(date){
  as.integer(as.POSIXct(date))
}

handle_params <- function(q = "",subreddit = NULL,size = 25,after = NULL,before = NULL,...){
  list(q = q, subreddit = subreddit, size = size, after = NULL, before = NULL,...)
}

