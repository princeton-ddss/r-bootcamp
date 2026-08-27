# R Bootcamp Day 2: Base R guided exercises

# Shared data ----
states <- data.frame(
  state = state.name,
  region = state.region,
  population = state.x77[, "Population"],
  income = state.x77[, "Income"],
  hs_grad = state.x77[, "HS Grad"],
  murder_rate = state.x77[, "Murder"],
  life_expectancy = state.x77[, "Life Exp"]
)

# Exercise 1: proportion above a cutoff ----

# Write prop_above() to compute the proportion of values above a cutoff.
prop_above <- function(x, cutoff, na.rm = TRUE) {
  # TODO: replace this placeholder with your code
  NA_real_
}

turnout <- c(0.71, 0.88, NA, 0.93, 0.65)
prop_above(turnout, cutoff = 0.80)

# Exercise 2: compare regions ----

# Write region_summary() to return:
# - the number of states
# - mean income
# - mean high school graduation rate
# - mean life expectancy
# TODO: replace each placeholder below with your code.
region_summary <- function(data, na.rm = TRUE) {
  c(
    n = NA_real_,
    mean_income = NA_real_,
    mean_hs_grad = NA_real_,
    mean_life_expectancy = NA_real_
  )
}

# Test on one group before adding iteration.
northeast <- states[states$region == "Northeast", ]
region_summary(northeast)

# Split the data by region and apply the function to each group.
states_by_region <- split(states, states$region)
result <- lapply(states_by_region, region_summary)

class(result)
str(result)

# What is the type of result?
# What is the type of each element?
# Which names were preserved?

# Add an na.rm argument to region_summary() and pass it to each summary
# function. Then test it with a missing income value.
northeast$income[1] <- NA
region_summary(northeast)

# Does the function still return four values?
