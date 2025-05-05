library(conflicted)
library(tidyverse)
library(yaml)
conflicts_prefer(dplyr::filter)
source(here::here("R", "find_authors.R"))

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
yaml1 <- function(a, user_groups) {
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
  if(length(ints)==1) ints <- list(ints)
  if(length(ints)>0) out <- c(out, list(interests=ints))

  if(!missing(user_groups) && a$Code %in% user_groups$Code) {
    out$user_groups <- user_groups |> filter(Code==a$Code) |> pull(Group) |> to_list()
  }
  
  out$superuser <- FALSE
  
  out <- paste0("---\n", as.yaml(out), "---")
  
}

d <- read_csv(here::here("R", "people.csv"))

groups <- local({
  ## ONLY INCLUDE ON WEB SITE IF HAS EITHER "Title" or "Education 1"
  has_profile <- d$Code[!is.na(d$Title) | !is.na(d$Education1)]
  heads <- c("norabello", "brucecraig")
  members <- setdiff(has_profile, heads)
  bind_rows(tibble(Group="Heads", Code=heads),
            tibble(Group="Members", Code=members))
})

## make authors folder if needed
apath <- "content/authors"
dir.create_if(apath)

## for each row that has a code, 
## make folder if needed, get the yaml, and write to the file
aut <- d |> filter(!is.na(Code))
for(idx in seq_len(nrow(aut))) {
  a <- aut[idx,]
  dir.create_if(file.path(apath, a$Code))
  yaml1(a, user_groups=groups) |> cat(file=file.path(apath, a$Code, "_index.md"))
}

