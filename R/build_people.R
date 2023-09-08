library(tidyverse)
library(yaml)
library(googlesheets4)
library(googledrive)

# authorize google access
# googlesheets4::gs4_auth()
# googledrive::drive_auth()

# The links to the spreadsheet and photos folder:
# https://docs.google.com/spreadsheets/d/1NNMWOoCZCW4COgzmy13xn-JzqD_g5DqAhahL3BnqQv8
# https://drive.google.com/drive/folders/1bAYRkwYp_yJuaQDFDgQd8PLnovyIh-8g
roster_google_id <- "1NNMWOoCZCW4COgzmy13xn-JzqD_g5DqAhahL3BnqQv8"
roster_photos_id <- "1bAYRkwYp_yJuaQDFDgQd8PLnovyIh-8g"

## helper function to create a directory if it doesn't exist
dir.create_if <- function(x) if(!dir.exists(x)) dir.create(x)

## helper function to take a data frame and turn into a list as needed for yaml
listify <- function(x) {
  vv <- function(x) {
    out <- as.vector(x)
    out[!is.na(out) & out!=""]
  }
  x <- x[rowSums(!is.na(x) & x!="") > 0,]
  x |> mutate(idx=seq_len(n())) |> group_by(idx) |> nest() |>
    mutate(a=map(data, vv)) |> pull(a)
}

## a complicated function to read a row of the spreadsheet
## and turn it into the desired yaml
yaml1 <- function(a) {
  stopifnot(nrow(a)==1)
  out <- list(first_name = a$First,
              last_name = a$Last,
              title = paste(a$First, a$Last))
  
  if(!is.na(a$Title)) out <- c(out, list(role=a$Title))
  
  org <- tibble(name=a$Affiliation, url=a$AffiliationLink) |> listify()
  if(length(org)>0) out <- c(out, list(organizations=org))
  
  educ <- tibble(Educ=a |> select(starts_with("Education")) |> unlist()) |>
    filter(!is.na(Educ)) |> 
    separate(Educ, c("course", "institution", "year"), sep="; *", convert = TRUE) |>
    listify()
  if(length(educ)>0) out <- c(out, list(education=list(courses=educ)))
  
  soc <- tribble(
    ~name, ~icon, ~icon_pack,
    "Email", "envelope", "fas", 
    "Website", "globe", "fas", 
    "GoogleScholar", "google-scholar", "ai", 
    "ORCID", "orcid", "ai", 
    "Github", "github", "fab", 
    "LinkedIn", "linkedin", "fab") |>
    mutate(link=a[name] |> unlist() |> unname()) |>
    filter(!is.na(link)) |> select(-name) |>
    listify()
  if(length(soc)>0) out <- c(out, list(social=soc))
  
  ints <- str_split(a$Interests, "; *")[[1]] |> setdiff(c(NA, ""))
  if(length(ints)>0) out <- c(out, list(interests=ints))

  if (a$Code %in% c("norabello", "brucecraig")) {
    out$user_groups <- list("Heads")
  } else {
    out$user_groups <- list("Members")
  }
  
  out$superuser <- FALSE
  
  out <- paste0("---\n", as.yaml(out), "---")
  
}

  
## read google sheet, fix names, and prep Email column
d0 <- read_sheet(roster_google_id, skip=1)
d <- d0 |> 
  rename_with(str_replace_all, pattern="[ ?]", replacement="") |>
  mutate(DisplayEmail=DisplayEmail |> na_if("No"),
         Email = if_else(!is.na(DisplayEmail) & DisplayEmail=="Yes", Email, DisplayEmail),
         Email = if_else(!is.na(Email), paste0("mailto:", Email), NA)) |>
  select(-DisplayEmail)

## get list of photos in photos folder
img <- drive_ls(as_id(roster_photos_id)) |>
  mutate(name=str_remove(name, "\\.jpg$"))

## make authors folder if needed
apath <- "content/authors"
dir.create_if(apath)

## for each row that has a code
aut <- d |> filter(!is.na(Code))
for(idx in seq_len(nrow(aut))) {
  a <- aut[idx,]
  ## make folder if needed
  dir.create_if(file.path(apath, a$Code))
  ## get the yaml and write to the file
  yaml1(a) |> cat(file=file.path(apath, a$Code, "_index.md"))
  ## download the photo if there is one
  if(!is.na(imgk <- match(a$Code, img$name))) {
    message("downloading ", a$Code)
    imgpath <- file.path(apath, a$Code, "avatar.jpg")
    googledrive::drive_download(img[imgk,], path=imgpath, overwrite=TRUE)
    ## reduce file size of avatar image
    system2("mogrify", paste("-resize '1200x1200>' -sampling-factor 4:2:0 -strip -quality 75 -interlace JPEG", imgpath))
  }
}

