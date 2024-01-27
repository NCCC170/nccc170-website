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
  x <- unlist(x)
  a <- namelist |> mutate(k=str_locate(paste(x, collapse="\n"), fixed(namelist$name))[,1]) |>
    filter(!is.na(k)) |> arrange(k) |> 
    mutate(unique=sprintf("◊%02d◊", seq_len(n())),
           display=sprintf('{{%% mention_name "%s" "%s" %%}}', code, name))
  if(nrow(a) > 0) {
    disp <- x |> 
      stringi::stri_replace_all_fixed(a$name, a$unique, vectorize_all = FALSE) |>
      stringi::stri_replace_all_fixed(a$unique, a$display, vectorize_all = FALSE)
    list(code=unique(a$code), display=disp) |> lapply(to_list)
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
