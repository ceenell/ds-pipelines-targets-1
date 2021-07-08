library(targets)
source("1_fetch/src/fetch_sb.R")
source("2_process/src/prep_data.R")
source("3_visualize/src/plot_data.R")
tar_option_set(packages = c("tidyverse", "stringr", "sbtools", "whisker"))

list(
  # Get the data from ScienceBase
  tar_target(
    model_RMSEs_csv,
    fetch_sb(fetch_dir = "1_fetch/out/",sb_file = "me_RMSE.csv", sbitem = "5d925066e4b0c4f70d0d0599", out_file = "model_RMSEs.csv"),
    format = "file"
  ), 
  # Prepare the data for plotting
  tar_target(
    eval_data,
    prep_data(file_in = model_RMSEs_csv)),
  ),
  # Create a plot
  tar_target(
    figure_1_png,
    plot_data(plot_out = "3_visualize/out/figure_1.png", data = eval_data), 
    format = "file"
  ),
  # Save the processed data
  tar_target(
    model_summary_results_csv,
    write_csv(eval_data, file = "2_process/out/model_summary_results.csv"), 
    format = "file"
  ),
  # Save the model diagnostics
  tar_target(
    model_diagnostic_text_txt,
    save_diagnostics(eval_data, project_output_dir = "2_process/out/", file_diag = "model_diagnostic_text.txt"), 
    format = "file"
  )
)

