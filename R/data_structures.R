parse_comment <- function(comment){
  empty <- empty[["comment"]]
  if (is.null(comment)) {
    output <- empty
  } else{
    singular_fields <- c("archived", "associated_award", "author", "author_flair_background_color",
                         "author_flair_css_class", "author_flair_template_id", "author_flair_text",
                         "author_flair_text_color", "author_flair_type", "author_fullname",
                         "author_patreon_flair", "author_premium", "body", "body_sha1",
                         "can_gild", "collapsed", "collapsed_because_crowd_control", "collapsed_reason",
                         "collapsed_reason_code", "comment_type", "controversiality",
                         "created_utc", "distinguished", "gilded", "id", "is_submitter",
                         "link_id", "locked", "no_follow", "parent_id", "permalink", "retrieved_utc",
                         "score", "score_hidden", "send_replies", "stickied", "subreddit",
                         "subreddit_id", "subreddit_name_prefixed", "subreddit_type",
                         "top_awarded_type", "total_awards_received", "unrepliable_reason"
    )
    singular_list <- lapply(comment[singular_fields], function(x) ifelse(is.null(x),
                                                                        NA, x))
    names(singular_list) <- singular_fields
    output <- tibble::as_tibble(singular_list)
    list_fields <- c("all_awardings", "author_flair_richtext", "gildings", "treatment_tags")
    for(field in list_fields){
      if(length(comment[[field]])==0){
        output[[field]] <- I(list(list()))
      } else{
        output[[field]] <- list(dplyr::bind_rows(comment[[field]]))
      }

    }
  }
  output
}

v <- function (FUN) {
  v_FUN <- function(x) {
    dplyr::bind_rows(lapply(x, FUN))
  }
  return(v_FUN)
}
