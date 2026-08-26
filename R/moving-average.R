# Function: Moving average calculator
library(tidyverse)

# The input to this function should be a data frame containing stream chemistry data
moving_average <- function(c_data) {
  # Initialize a tibble to contain the results
  result <- tibble(
    window_start = seq(
      min(c_data$Sample_Date),
      max(c_data$Sample_Date),
      by = "9 weeks"
    ),
    k_mgL = NA,
    mg_mgL = NA,
    # Fill in the rest of the ions
    `no3-n_ugL` = NA,
    ca_mgL = NA,
    `nh4-n_ugL` = NA
  )

  # Fill in the iterator and sequence
  for (i in 1:nrow(result)) {
    # Create variables for the start and end of the current window
    w1 <- result$window_start[i]
    w2 <- w1 + weeks(9)

    # Create a logical vector, called "in_window", that says which samples are inside the window
    # Hint: you'll compare sample dates to the start and end of the window
    in_window <- c_data$Sample_Date >= w1 & c_data$Sample_Date < w2

    # Use indexing to pull out the ion concentrations that fall inside the window
    k_window <- c_data$K[in_window]
    # The line above gets potassium in the window. Get the rest of the ions too
    mg_window <- c_data$Mg[in_window]
    non_window <- c_data$`NO3-N`[in_window]
    ca_window <- c_data$Ca[in_window]
    nhn_window <- c_data$`NH4-N`[in_window]

    # Calculate the mean of each ion concentration and fill in the result
    result$k_mgL[i] <- mean(k_window, na.rm = TRUE)
    result$mg_mgL[i] <- mean(mg_window, na.rm = TRUE)
    result$`no3-n_ugL`[i] <- mean(non_window, na.rm = TRUE)
    result$ca_mgL[i] <- mean(ca_window, na.rm = TRUE)
    result$`nh4-n_ugL`[i] <- mean(nhn_window, na.rm = TRUE)
  }

  # Return the result
  return(result)
}
