library(targets)
source("1_fetch/src/fetch_sb.R")
source("2_process/src/prep_data.R")
source("3_visualize/src/plot_data.R")
tar_option_set(packages = c("tidyverse", "stringr", "sbtools", "whisker"))

list(
  # Get the data from ScienceBase
  tar_target(
    model_RMSEs_csv,
    fetch_sb(out_filepath = "1_fetch/out/model_RMSEs.csv"),
    format = "file"
  ), 
  # Prepare the data for plotting
  tar_target(
    eval_data,
    prep_data(in_filepath = model_RMSEs_csv),
  ),
  # Create a plot
  tar_target(
    figure_1_png,
    plot_data(out_filepath = "3_visualize/out/figure_1.png", data = eval_data), 
    format = "file"
  ),
  # Save the processed data
  tar_target(
    model_summary_results_csv,
    write_csv(eval_data, file = "model_summary_results.csv"), 
    format = "file"
  ),
  # Save the model diagnostics
  tar_target(
    model_diagnostic_text_txt,
    save_diagnostics(out_filepath = "model_diagnostic_text.txt", data = eval_data), 
    format = "file"
  )
)

