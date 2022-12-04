## code to prepare `ps_params` dataset goes here
df <- rvest::read_html("https://pushshift.io/api-parameters/") |>
  rvest::html_table()
df[[1]]$Endpoint
df[[1]]$Parameter

ps_params <- df[[1]]

usethis::use_data(ps_params, overwrite = TRUE)
