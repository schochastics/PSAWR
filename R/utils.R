make_get_request <- function(path,params,FUN,verbose = verbose,parse_date = TRUE){
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
    Sys.sleep(0.6) #ratelimit 100 requests per minute
    tmp <- httr::content(resp)$data
    output <- c(output,tmp)
    params[[pager]] <- tmp[[length(tmp)]][["created_utc"]]
    i <- i+1
    nobj <- nobj + length(tmp)
    if (isTRUE(verbose)) {
      cat("got",min(nobj,n),"of",n,"results","\r")
    }
  }
  if (isTRUE(verbose)) {
    cat("\n")
  }
  result <- FUN(output)[1:n,]
  if(isTRUE(parse_date)){
    result[["created_utc"]] <- as.POSIXct(result[["created_utc"]], origin = "1970-01-01")
  }
  result
}

#' convert date to epoch time
#'
#' @param date date to be converted
#'
#' @return epoch time as integer
#' @export
#'
#' @examples
#' to_epoch("2022-12-01")
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
