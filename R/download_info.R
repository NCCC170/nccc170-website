library(conflicted)
library(tidyverse)
conflicts_prefer(dplyr::filter)
# library(googlesheets4)

# authorize google access
# googlesheets4::gs4_auth()

# The links to the spreadsheet:
# https://docs.google.com/spreadsheets/d/1NNMWOoCZCW4COgzmy13xn-JzqD_g5DqAhahL3BnqQv8
roster_google_id <- "1NNMWOoCZCW4COgzmy13xn-JzqD_g5DqAhahL3BnqQv8"

## read google sheet, fix names, and prep Email column
d0 <- bind_rows(googlesheets4::read_sheet(roster_google_id, sheet=1, skip=1),
                googlesheets4::read_sheet(roster_google_id, sheet=2, skip=1)) |>
  arrange(str_to_upper(Last), str_to_upper(First))
d <- d0 |> 
  rename_with(str_replace_all, pattern="[ ?]", replacement="") |>
  mutate(DisplayEmail=DisplayEmail |> na_if("No"),
         Email = if_else(!is.na(DisplayEmail) & DisplayEmail=="Yes", Email, DisplayEmail),
         Email = if_else(!is.na(Email), paste0("mailto:", Email), NA)) |>
  select(-DisplayEmail)

write_csv(d, here::here("R", "people.csv"), na = "")
