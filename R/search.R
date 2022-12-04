search_submissions <- function(q = "",subreddit = NULL,size = 25,after = NULL,before = NULL,...){
  params <- handle_params(q = q, subreddit = subreddit,size = size, after = after, before = before,...)
  make_get_request(path = "reddit/submission/search",params = params,FUN = v(parse_submission))
}

#' Search Pushshift.io for Reddit comments
#'
#' @param q character, Query term
#' @param subreddit Restrict results to subreddit (use "!" to negate, comma delimited for multiples)
#' @param size integer, number of results to return
#' @param after Restrict results to those made after this epoch time
#' @param before Restrict results to those made before this epoch time
#' @param ...  Further arguments passed as query parameters. See [ps_params] for all possible parameters.
#'
#' @return tibble of comments
#' @export
search_comments <- function(q = "",subreddit = NULL,size = 25,after = NULL,before = NULL,...){
  params <- handle_params(q = q, subreddit = subreddit,size = size, after = after, before = before,...)
  make_get_request(path = "reddit/comment/search",params = params,FUN = v(parse_comment))
}
