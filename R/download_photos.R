library(conflicted)
library(tidyverse)
conflicts_prefer(dplyr::filter)
# library(googledrive)

# authorize google access
# googledrive::drive_auth()

# The link to the photos folder:
# https://drive.google.com/drive/folders/1bAYRkwYp_yJuaQDFDgQd8PLnovyIh-8g
roster_photos_id <- "1bAYRkwYp_yJuaQDFDgQd8PLnovyIh-8g"

## get list of photos in photos folder
img <- googledrive::drive_ls(googledrive::as_id(roster_photos_id)) |>
  mutate(name=str_remove(name, "\\.jpg$"))

apath <- "content/authors"
img_use <- img |> filter(file.exists(file.path(apath, name)))

img_use <- img |> filter(!file.exists(file.path(apath, name, "avatar.jpg")))

## download the photo if there is one
for(idx in seq_len(nrow(img_use))) {
  code <- img_use$name[idx]
  message("downloading ", code)
  imgpath <- file.path(apath, code, "avatar.jpg")
  googledrive::drive_download(img_use[idx,], path=imgpath, overwrite=TRUE)
  ## reduce file size of avatar image
  system2("mogrify", paste("-resize '1200x1200>' -sampling-factor 4:2:0 -strip -quality 75 -interlace JPEG", imgpath))
}
