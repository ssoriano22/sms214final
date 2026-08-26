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

# Combine data dfs here - below code only uses Q2_Bisley as of 25AUG2026

combo_data <- rbind(Q1_Bisley_data, Q2_Bisley_data, Q3_Bisley_data, PRM_data)
clean_combo_data <- combo_data |>
  # Rename MPR Sample_ID to PRM (might change later?)
  mutate(Sample_ID = fct_recode(Sample_ID, PRM = "MPR"))

# Calculate moving average - 9wk

# Call moving average function from R/ - just Q2_Bisley to test function first
smooth_data <- moving_average(Q2_Bisley_data)

# Pivot longer to create ion columns (and sample_loc - future task)
smooth_data_longer <- smooth_data |>
  #select(window_start, k_mgL, mg_mgL) |> #Using since only plotting 2 ions
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
    color = fct_recode(
      Ion,
      K = "k_mgL",
      Mg = "mg_mgL",
      `NO3-N` = "no3-n_ugL",
      Ca = "ca_mgL",
      `NH4-N` = "nh4-n_ugL"
    )
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
