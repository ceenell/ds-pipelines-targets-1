# Get the data from ScienceBase
fetch_sb <- function(project_output_dir = '1_fetch/out') {
  if(!dir.exists(project_output_dir)){
    dir.create(project_output_dir)
  }
  sb_fp <- file.path(project_output_dir, 'model_RMSEs.csv')
  sbtools::item_file_download('5d925066e4b0c4f70d0d0599', names = 'me_RMSE.csv', destinations = sb_fp, overwrite_file = TRUE)
}


