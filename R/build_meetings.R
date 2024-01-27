library(tidyverse)
source(here::here("R", "find_authors.R"))

yaml_flexible <- function(x, force_list=c())  {
  while(grepl("^\\s*$", tail(x, 1))) {
    x <- head(x, -1)
  }
  ## inspired by xfun::yaml_body
  i <- grep("^---\\s*$", x)
  n <- length(i)
  stopifnot(n<=1)
  if(n==0) {
    list(yaml = yaml::yaml.load(x) |> make_list(force_list))
  } else {
    list(yaml = yaml::yaml.load(x[1:(i-1)]) |> make_list(force_list), 
         body = x[(i+1):length(x)])
  }
}

split_time <- function(x) {
  if(!is.null(x$yaml$time)) {
    sp <- str_split(x$yaml$time, " ", n=2)[[1]]
    if(length(sp)==2) {
      x$yaml$time <- sp[1]
      x$yaml$about <- sp[2]
      nn <- c("time", "about")
      x$yaml <- x$yaml[c(nn, setdiff(names(x$yaml), nn))]
    }
    x$yaml$time <- x$yaml$time |> str_replace(" *a$", " AM") |> str_replace(" *p$", " PM")
  }
  x
}

fill_dates <- function(x) {
  has_date <- sapply(x, function(x) !is.null(x$yaml$date))
  if(!any(has_date)) return(x)
  dates <- sapply(x[has_date], function(x) x$yaml$date)
  x[[1]]$yaml$date <- dates[1]
  if(length(dates) > 1) {
    x[[1]]$yaml$date_end <- dates[length(dates)]
  }
  cur_date <- NA
  for(idx in seq_along(x)) {
    cur_yaml <- x[[idx]]$yaml
    if(!is.null(cur_yaml$date)) {
      cur_date <- cur_yaml$date
    } else if (!is.na(cur_date)) {
      if(!is.null(cur_yaml$time)) {
        cur_yaml$date <- lubridate::ymd_hm(paste(cur_date, cur_yaml$time)) |> 
          format("%Y-%m-%dT%H:%M:%S")
        cur_yaml$time <- NULL
      } else {
        cur_yaml$date <- cur_date
      }
      nn <- names(cur_yaml)
      x[[idx]]$yaml <- cur_yaml[c("date", setdiff(nn, "date"))]
    }
  }
  only_date <- sapply(x, function(x) {
    !is.null(x$yaml$date) & is.null(x$body) & (length(x$yaml)==1)
  })
  x[!only_date]
}

add_types <- function(x) {
  x[[1]]$yaml$all_day <- TRUE
  x[[1]]$yaml$type <- "meeting"
  x[[1]]$yaml$view <- "schedule"
  # for(idx in seq_along(x[-1])) {
  #   xi <- x[[idx]]
  #   if(!is.null(xi$body)) {
  #     xi$yaml$categories <- list("Meeting Talks")
  #   }
  #   x[[idx]] <- xi
  # }
  x
}

read_meeting <- function(file, namelist, verbose=TRUE) {
  if(verbose) message(sprintf("Reading %s..", file))
  txt <- readLines(file)
  k <- (str_detect(txt, "^date:") | str_detect(txt, "^time:")) |> cumsum()
  out <- split(txt, k) |> 
    lapply(yaml_flexible, force_list=c("authors")) |> 
    lapply(split_time) |>
    fill_dates() |>
    lapply(add_authors, namelist) |>
    add_types()
  if(!is.null(out[[1]]$yaml$participants)) {
    participants <- out[[1]]$yaml$participants |> find_authors(namelist)
    out[[1]]$yaml$participants <- participants$display
    yi <- list(file="participants",
               yaml=list(title="Participant", 
                         authors=participants$code, 
                         authorlist=participants$display,
                         date=out[[1]]$yaml$date, date_end=out[[1]]$yaml$date_end, type="role"))
    out <- c(out, list(yi))
  }
  if(!is.null(out[[1]]$yaml$leadership)) {
    leadership <- out[[1]]$yaml$leadership |> map(bind_rows) |> bind_rows() |>
      mutate(file=role |> str_remove("[^A-Za-z]") |> tolower()) |>
      mutate(n=n(), file=if_else(n>1, paste0(file, 1:n()), file), .by=file) |> select(-n) |>
      mutate(map(who, \(x) find_authors(x, namelist) |> map(unlist) |> bind_rows()) |> bind_rows())
    out[[1]]$yaml$leadership <- leadership |> select(role, who=display) |> purrr::transpose()
    yi <- leadership |> mutate(authors=map(code, list), authorlist=map(display, list)) |>
      select(file, title=role, authors, authorlist) |> 
      mutate(date=out[[1]]$yaml$date, date_end=out[[1]]$yaml$date_end, type="role") |>
      purrr::transpose() |>
      map(\(x) list(file=x$file, yaml=list_modify(x, file=zap())))
    out <- c(out, yi)
  }
  out
}

write_meeting <- function(m, outdir, verbose=TRUE) {
  if(verbose) message(sprintf("Writing files for %s...", m[[1]]$yaml$title))
  for(idx in seq_along(m)) {
    x <- m[[idx]]
    if(idx==1) {
      file <- "_index"
    } else if(!is.null(x$file)) {
      file <- x$file
    } else {
      file <- x$yaml$date |> str_remove_all("[-: ]") |> str_replace("T", "_") |> str_remove("00$")
    }
    write_yaml(x, file, dir=outdir, verbose=verbose)
  }
}

people <- read_authors(here::here("R", "people.csv"))
mtgs <- list.files(pattern="meeting.txt", path="content/meetings", recursive=TRUE, full.names = TRUE)
for(path1 in dirname(mtgs)) {
  file.remove(list.files(path1, pattern="*.md", full.names = TRUE))
  m <- read_meeting(file.path(path1, "meeting.txt"), namelist=people)
  write_meeting(m, path1)
}
