library(tidycensus)
library(tidyverse)

county_data <- get_acs(
  geography = 'county',
  variables = c(
    income = 'B25119_001',
    rent = 'B25064_001'
  ),
  survey = 'acs5',
  year = 2023L
) |>
  tidyr::pivot_wider(
    names_from = variable,
    values_from = c(estimate, moe),
    names_glue = '{variable}_{.value}'
  ) |>
  dplyr::rename(
    income = income_estimate,
    rent = rent_estimate
  ) |>
  tidyr::separate(
    NAME,
    into = c('county', 'state'),
    sep = ', ',
    remove = FALSE
  ) |>
  dplyr::select(GEOID, state, county, income, income_moe, rent, rent_moe) |>
  filter(state != 'Puerto Rico')

write_csv(county_data, here::here('files/county_data.csv'))
