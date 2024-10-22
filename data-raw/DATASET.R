## code to prepare `DATASET` dataset goes here
library(tidyverse)
library(tidytext)
world_fairs <- read_csv("data-raw/worlds_fairs.csv")

# Data preparation for Top Themes
themes_words <- world_fairs %>%
  unnest_tokens(word, theme) %>%
  count(category, word, sort = TRUE) %>%
  ungroup()

# Remove unnecessary words
themes_words <- themes_words %>%
  anti_join(stop_words, by = "word")

# Get the top 10 most common words for World Expo
top_words_world <- themes_words %>%
  filter(category == "World Expo") %>%
  top_n(10, n)

# Get the top 10 most common words for Specialised Expo
top_words_spec <- themes_words %>%
  filter(category == "Specialised Expo") %>%
  top_n(10, n)

# Data preparation for Economic Factors Table
expo_world_filtered <- world_fairs %>%
  filter(category == "World Expo", cost > 0, visitors > 0, attending_countries > 0)

expo_spec_filtered <- world_fairs %>%
  filter(category == "Specialised Expo", cost > 0, visitors > 0, attending_countries > 0)

summary_table_world <- expo_world_filtered %>%
  summarise(
    mean_cost = mean(cost, na.rm = TRUE),
    median_cost = median(cost, na.rm = TRUE),
    mean_visitors = mean(visitors, na.rm = TRUE),
    median_visitors = median(visitors, na.rm = TRUE),
    mean_attending_countries = mean(attending_countries, na.rm = TRUE),
    median_attending_countries = median(attending_countries, na.rm = TRUE)
  )

summary_table_specialised <- expo_spec_filtered %>%
  summarise(
    mean_cost = mean(cost, na.rm = TRUE),
    median_cost = median(cost, na.rm = TRUE),
    mean_visitors = mean(visitors, na.rm = TRUE),
    median_visitors = median(visitors, na.rm = TRUE),
    mean_attending_countries = mean(attending_countries, na.rm = TRUE),
    median_attending_countries = median(attending_countries, na.rm = TRUE)
  )

summary_combined <- bind_rows(
  summary_table_world %>% mutate(expo_type = "World Expo"),
  summary_table_specialised %>% mutate(expo_type = "Specialised Expo")
) %>%
  tibble() %>%
  select(expo_type, everything())

# Combine all into one list
combined_data <- list(
  top_words_world = top_words_world,
  top_words_spec = top_words_spec,
  summary_combined = summary_combined
)

# Save the combined data set
usethis::use_data(combined_data, overwrite = TRUE)
