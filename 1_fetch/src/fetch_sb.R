# Get the data from ScienceBase
fetch_sb <- function(fetch_dir, sb_file, sbitem, out_file) {
  if(!dir.exists(fetch_dir)){
    dir.create(fetch_dir)
  }
  sb_fp <- file.path(fetch_dir, out_file)
  sbtools::item_file_download(sbitem, names = sb_file, destinations = sb_fp, overwrite_file = TRUE)
}


