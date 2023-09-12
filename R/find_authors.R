library(tidyverse)

to_list <- function(x) { if(length(x) == 1) { list(x) } else { x } }
make_list <- function(x, n) {
  for(ni in n) { x[[ni]] <- to_list(x[[ni]]) }
  x
}
write_yaml <- function(yaml, file, dir=".", path=file.path(dir, paste0(file, ".md")), verbose=TRUE) {
  if(verbose) message(sprintf(" - %s", path))
  if(!is.null(yaml$body)) {
    yaml$body <- paste0(paste(yaml$body, collapse="\n"), "\n")
  }
  c("---\n", yaml::as.yaml(yaml$yaml), "---\n", yaml$body) |> cat(file=path, sep="")
}

read_authors <- function(file) {
  read_csv(file, show_col_types = FALSE) |>
    mutate(Name=paste(First, Last)) |> select(code=Code, name=Name, alt="AlternateNames") |>
    separate(alt, paste("name", 1:5), sep="; *", fill="right") |>
    pivot_longer(-code, values_drop_na=TRUE, names_to="X", values_to="name") |> select(-X)
}

find_authors <- function(x, namelist) {
  ## put back to a vector and see which are present
  x <- unlist(x)
  a <- namelist[str_detect(paste(x, collapse="\n"), fixed(namelist$name)),]
  if(nrow(a) > 0) {
    pat <- a$name
    rep <- sprintf('{{%% mention_name "%s" "%s" %%}}', a$code, a$name)
    disp <- stringi::stri_replace_all_fixed(x, pat, rep, vectorize_all = FALSE)
    list(code=a$code, display=disp) |> lapply(to_list)
  } else {
    list(display=to_list(x))
  }
}

add_authors <- function(x, namelist, from="authors") {
  a <- find_authors(x$yaml[[from]], namelist)
  x$yaml$authors <- a$code
  x$yaml$authors_display <- a$display
  x
}
