## to update copyright year, edit config/_default/params.yaml

## if running the server, best to stop before rebuilding the site
blogdown::stop_server()

## download info from the google drive
source(here::here("R", "download_info.R"))
source(here::here("R", "download_photos.R"))

## and rebuild the automatically generated parts of the site
source(here::here("R", "build_people.R"))
source(here::here("R", "build_meetings.R"))
source(here::here("R", "build_publications.R"))

rmarkdown::render_site(encoding = 'UTF-8')

blogdown::serve_site()
