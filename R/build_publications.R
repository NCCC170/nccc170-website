library(tidyverse)
source(here::here("R", "find_authors.R"))

people <- read_authors(here::here("R", "people.csv"))

pubs <- basename(list.dirs("content/publication")) |> setdiff("publication")

for(glub in pubs) {
  f <- sprintf("content/publication/%s/index.md", glub)
  ## read in the current yaml, fix missing/blank lines in body
  y <- xfun::yaml_body(readLines(f))
  if(all(y$body=="")) {
    y$body <- NULL
  } else {
    y$body <- y$body[which(y$body!="")[1]:length(y$body)]
  }
  ## add the authors and write out (to same file!)
  y2 <- add_authors(y, namelist=people, from="author_names")
  y2$yaml <- make_list(y2$yaml, "publication_types")
  write_yaml(y2, path=f)
}
