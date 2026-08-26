# Spaghetti Script - EDS214 Day 1 PM, Day 2 AM (Merge Conflict)

# Load packages
library(tidyverse)
library(reprex)
library(ggh4x)

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

# Initialize smoothed df w/ window_start
Q2_Bisley_smooth <- tibble(
  window_start = seq(
    ymd(min(Q2_Bisley_data$Sample_Date)), #Will need to be adjusted for other sites
    ymd(max(Q2_Bisley_data$Sample_Date)), #Possibly needs to be adjusted?
    by = "9 weeks"
  ),
  k_mgL = NA,
  mg_mgL = NA,
  `no3-n_ugL` = NA,
  ca_mgL = NA,
  `nh4n_ugL` = NA
)

#Calculate mean conc./ion from raw data
for (i in 1:nrow(Q2_Bisley_smooth)) {
  # i is our iterator
  # 1:nrows(Q2_Bisley_smooth) is our sequence
  # i will take on those values, one at a time

  # Define window start date
  w1 <- Q2_Bisley_smooth$window_start[i]

  # Define window end date
  w2 <- w1 + weeks(9)

  # What ion values are inside that window?
  # Potassium (K)
  Q2_Bisley_data_K <- Q2_Bisley_data$K[
    Q2_Bisley_data$Sample_Date >= w1 & Q2_Bisley_data$Sample_Date < w2
  ]
  # Magnesium (Mg)
  Q2_Bisley_data_Mg <- Q2_Bisley_data$Mg[
    Q2_Bisley_data$Sample_Date >= w1 & Q2_Bisley_data$Sample_Date < w2
  ]
  # Nitrate-Nitrogen (NO3-N)
  Q2_Bisley_data_NON <- Q2_Bisley_data$`NO3-N`[
    Q2_Bisley_data$Sample_Date >= w1 & Q2_Bisley_data$Sample_Date < w2
  ]
  # Calcium (Ca)
  Q2_Bisley_data_Ca <- Q2_Bisley_data$Ca[
    Q2_Bisley_data$Sample_Date >= w1 & Q2_Bisley_data$Sample_Date < w2
  ]
  # Ammonium Nitrogen (NH4N)
  Q2_Bisley_data_NHN <- Q2_Bisley_data$`NH4-N`[
    Q2_Bisley_data$Sample_Date >= w1 & Q2_Bisley_data$Sample_Date < w2
  ]

  #Calculate means with data points within window
  mean_K <- mean(Q2_Bisley_data_K, na.rm = TRUE)
  mean_Mg <- mean(Q2_Bisley_data_Mg, na.rm = TRUE)
  mean_NON <- mean(Q2_Bisley_data_NON, na.rm = TRUE)
  mean_Ca <- mean(Q2_Bisley_data_Ca, na.rm = TRUE)
  mean_NHN <- mean(Q2_Bisley_data_NHN, na.rm = TRUE)

  #Store mean per ion in smoothed df
  Q2_Bisley_smooth$k_mgL[i] <- mean_K
  Q2_Bisley_smooth$mg_mgL[i] <- mean_Mg
  Q2_Bisley_smooth$`no3-n_ugL`[i] <- mean_NON
  Q2_Bisley_smooth$ca_mgL[i] <- mean_Ca
  Q2_Bisley_smooth$`nh4n_ugL`[i] <- mean_NHN
}

# Pivot longer to create ion columns (and sample_loc - future task)
Q2_Bisley_smooth_longer <- Q2_Bisley_smooth |>
  #select(window_start, k_mgL, mg_mgL) |> #Using since only plotting 2 ions
  pivot_longer(
    cols = k_mgL:`nh4n_ugL`,
    names_to = "Ion",
    values_to = "Mean_Concentration"
  )

# Visualization - Line Plot

# Set custom y axis scales and labels - only necessary for facetted_pos_scales() if used
# y_scales_labels <- list(
#   # For facet row 'A', define its scale name / breaks / limits
#   #A = scale_y_continuous(name = "A"),
#   B = scale_y_continuous(name = "B"),
#   C = scale_y_continuous(name = "C"),
#   D = scale_y_continuous(name = "D"),
#   E = scale_y_continuous(name = "E")
# )

# Line plot - ggplot2, facet_grid()
ggplot(
  data = Q2_Bisley_smooth_longer,
  mapping = aes(
    x = window_start,
    y = Mean_Concentration,
    color = fct_recode(
      Ion,
      K = "k_mgL",
      Mg = "mg_mgL",
      `NO3-N` = "no3-n_ugL",
      Ca = "ca_mgL",
      `NH4-N` = "nh4n_ugL"
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
# Maybe used to add independant y labels?
#facetted_pos_scales(y = y_scales_labels)
# Maybe used to set maunal line colors?
#scale_color_manual(values = c("#e3d727", "#690c8b"))
