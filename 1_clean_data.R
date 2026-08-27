# Script to load and clean hurricane stream data - cleaned data saved in output/

# Load packages and functions
library(tidyverse)
source(here::here("R/moving-average.R"))

# Read in data - 4 sites
Q1_Bisley_data <- read_csv(here::here("data/QuebradaCuenca1-Bisley.csv"))
Q2_Bisley_data <- read_csv(here::here("data/QuebradaCuenca2-Bisley.csv"))
Q3_Bisley_data <- read_csv(here::here("data/QuebradaCuenca3-Bisley.csv"))
PRM_data <- read_csv(here::here("data/RioMameyesPuenteRoto.csv"))

# Call moving average function from R/ for each of the 4 data df
sm_Q1_Bisley_data <- moving_average(Q1_Bisley_data)
sm_Q1_Bisley_data <- sm_Q1_Bisley_data |> mutate(Site_ID = "BQ1")
sm_Q2_Bisley_data <- moving_average(Q2_Bisley_data)
sm_Q2_Bisley_data <- sm_Q2_Bisley_data |> mutate(Site_ID = "BQ2")
sm_Q3_Bisley_data <- moving_average(Q3_Bisley_data)
sm_Q3_Bisley_data <- sm_Q3_Bisley_data |> mutate(Site_ID = "BQ3")
sm_PRM_data <- moving_average(PRM_data)
sm_PRM_data <- sm_PRM_data |> mutate(Site_ID = "PRM")

# Combine smoothed data from all 4 sites
combo_smooth_data <- rbind(
  sm_Q1_Bisley_data,
  sm_Q2_Bisley_data,
  sm_Q3_Bisley_data,
  sm_PRM_data
)

#Filter smooth data to years relevant to Figure 3 - 1988 to 1995
filt_smooth_data <- combo_smooth_data |>
  filter(year(window_start) >= 1988 & year(window_start) <= 1995)

# Save smoothed and filtered data to output folder
write_csv(filt_smooth_data, "output/combo_smooth_data.csv")
