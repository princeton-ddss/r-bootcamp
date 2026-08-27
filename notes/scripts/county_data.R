library(tidycensus)
library(tidyverse)

state_lookup <- censable::stata |>
  mutate(
    state_fips = stringr::str_pad(as.character(fips), width = 2L, pad = '0'),
    state = name,
    region,
    division,
    .keep = 'none'
  )

county_data <- get_acs(
  geography = 'county',
  variables = c(
    income = 'B25119_001',
    rent = 'B25064_001'
  ),
  survey = 'acs5',
  year = 2023L
) |>
  mutate(
    GEOID = stringr::str_pad(as.character(GEOID), width = 5L, pad = '0'),
    state_fips = stringr::str_sub(GEOID, 1L, 2L)
  ) |>
  tidyr::pivot_wider(
    names_from = variable,
    values_from = c(estimate, moe),
    names_glue = '{variable}_{.value}'
  ) |>
  rename(
    income = income_estimate,
    rent = rent_estimate
  ) |>
  tidyr::separate(
    NAME,
    into = c('county', 'state_from_acs'),
    sep = ', ',
    remove = FALSE
  ) |>
  left_join(state_lookup, by = 'state_fips') |>
  filter(state != 'Puerto Rico') |>
  select(GEOID, state, county, income, income_moe, rent, rent_moe)

write_csv(county_data, here::here('files/county_data.csv'))

county_population <- get_decennial(
  geography = 'county',
  variables = c(populations = 'P1_001N'),
  year = 2020L,
  sumfile = 'pl'
) |>
  mutate(
    fips = stringr::str_pad(as.character(GEOID), width = 5L, pad = '0'),
    state_fips = stringr::str_sub(fips, 1L, 2L)
  ) |>
  inner_join(state_lookup, by = 'state_fips') |>
  filter(!is.na(region), !is.na(division)) |>
  select(fips, region, division, pop = value)

write_csv(county_population, here::here('files/county_population.csv'))


shp <- tigris::counties(cb = TRUE, resolution = '20m') |>
  filter(STUSPS %in% c(state.abb, 'DC')) |>
  mutate(
    GEOID = stringr::str_pad(as.character(GEOID), width = 5L, pad = '0'),
    state_fips = stringr::str_sub(GEOID, 1L, 2L),
    county = NAMELSAD
  ) |>
  left_join(state_lookup, by = 'state_fips') |>
  tigris::shift_geometry() |>
  rmapshaper::ms_simplify(keep_shapes = TRUE, keep = 0.1) |>
  select(GEOID, state, county, geometry)

sf::st_write(
  shp,
  here::here('files', 'county_shapes.geojson'),
  delete_dsn = TRUE,
  quiet = TRUE
)
