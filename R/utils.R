make_get_request <- function(path,params,FUN,verbose = verbose){
  url <- httr::parse_url("")
  url$hostname <- "api.pushshift.io"
  url$scheme <- "https"
  #check if paging is needed
  n <- params[["size"]]
  page_size <- 249 #TODO:is 250 always the limit? seems to fluctuate also
  params[["size"]] <- min(params[["size"]],page_size)
  pages <- ceiling(n/page_size)
  output <- vector("list")
  if(!is.null(params[["after"]]) | !is.null(params[["after_id"]])){
    pager <- "after"
  } else{
    pager <- "before"
  }
  i <- 1
  nobj <- 0
  while(i<=pages | nobj<n){
    resp <- httr::GET(httr::modify_url(url,path = path),query=params)
    tmp <- httr::content(resp)$data
    output <- c(output,tmp)
    params[[pager]] <- tmp[[length(tmp)]][["created_utc"]]
    i <- i+1
    nobj <- nobj + length(tmp)
    if (isTRUE(verbose)) {
      cat("got",min(nobj,n),"of",n,"comments","\r")
    }
  }
  if (isTRUE(verbose)) {
    cat("\n")
  }
  FUN(output)[1:n,]
}

to_epoch <- function(date){
  as.integer(as.POSIXct(date))
}

handle_params <- function(q = "",subreddit = NULL,size = 25,after = NULL,before = NULL,...){
  list(q = q, subreddit = subreddit, size = size, after = after, before = before,...)
}

sayif <- function (verbose, ...)
{
  if (isTRUE(verbose)) {
    message(...)
  }
}
