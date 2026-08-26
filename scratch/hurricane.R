# Spaghetti Script - EDS214 Day 1 PM, Day 2 AM (Merge Conflict)

# Load packages
library(tidyverse)
library(reprex)
library(ggh4x)
source("R/moving-average.R")

# Read in data
Q1_Bisley_data <- read_csv("data/QuebradaCuenca1-Bisley.csv")
Q2_Bisley_data <- read_csv("data/QuebradaCuenca2-Bisley.csv")
Q3_Bisley_data <- read_csv("data/QuebradaCuenca3-Bisley.csv")
PRM_data <- read_csv("data/RioMameyesPuenteRoto.csv")
units_data <- read_csv("data/LUQ LTER MDLs.csv")

# Calculate moving average - 9wk

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

# Pivot longer to create ion columns
smooth_data_longer <- combo_smooth_data |>
  pivot_longer(
    cols = k_mgL:`nh4-n_ugL`,
    names_to = "Ion",
    values_to = "Mean_Concentration"
  )

# Visualization - Line Plot

# Line plot - ggplot2, facet_grid()
ggplot(
  data = smooth_data_longer,
  mapping = aes(
    x = window_start,
    y = Mean_Concentration,
    color = Site_ID
  )
) +
  geom_line() +
  theme_bw() +
  labs(
    title = "Ion Concentrations over Time",
    x = "Window Start Date",
    y = "Mean Concentration",
    color = "Ion"
  ) +
  facet_grid(Ion ~ ., scales = "free_y")
