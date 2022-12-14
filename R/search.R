#' Search Pushshift.io for Reddit comments
#'
#' @param q character, Query term
#' @param subreddit Restrict results to subreddit (use "!" to negate, comma delimited for multiples)
#' @param size integer, Number of results to return
#' @param after integer, Restrict results to those made after this epoch time
#' @param before integer, Restrict results to those made before this epoch time
#' @param parse_date logical, should epoch time be converted to date? defaults to TRUE
#' @param verbose logical, Whether to display messages
#' @param ...  Further arguments passed as query parameters. See [ps_params] for all possible parameters.
#' @details Use [to_epoch] to convert a date to epoch time
#' @return tibble of comments
#' @export
#' @examples
#' \dontrun{
#' # get the last 100 comments with the word 'cats'
#' search_comments(q = "cats", size = 100)
#' }
search_comments <- function(q = "",subreddit = NULL,size = 25,after = NULL,before = NULL,parse_date = TRUE,verbose = TRUE,...){
  params <- handle_params(q = q, subreddit = subreddit,size = size, after = after, before = before,...)
  make_get_request(path = "reddit/comment/search",params = params,FUN = v(parse_comment),parse_date = parse_date,verbose = verbose)
}

#' Search Pushshift.io for Reddit submissions
#'
#' @inheritParams search_comments
#' @details Use [to_epoch] to convert a date to epoch time
#' @return tibble of submissions
#' @export
#'
#' @examples
#' \dontrun{
#' # get the last 100 submissions with the word 'dogs' in the subreddit 'r/animals'
#' search_submissions(q = "dogs", subreddit = "animals", size = 100)
#' }
search_submissions <- function(q = "",subreddit = NULL,size = 25,after = NULL,before = NULL,parse_date = TRUE,verbose = TRUE,...){
  params <- handle_params(q = q, subreddit = subreddit,size = size, after = after, before = before,...)
  make_get_request(path = "reddit/submission/search",params = params,FUN = v(parse_submission),parse_date = parse_date,verbose = verbose)
}
