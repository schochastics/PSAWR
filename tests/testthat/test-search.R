test_that("search_comments", {
  vcr::use_cassette("search_comments_default", {
    x <- search_comments(q = "cats", size = 100,verbose = FALSE)
  })
  expect_true(nrow(x) == 100)
  expect_true("tbl_df" %in% class(x))
})

test_that("search_submissions", {
  vcr::use_cassette("search_submissions_default", {
    x <- search_submissions(q = "dogs", subreddit = "animals", size = 10,verbose = FALSE)
  })
  expect_true(nrow(x) == 10)
  expect_true("tbl_df" %in% class(x))
})
