## code to prepare `DATASET` dataset goes here
library(tidyverse)
world_fairs <- read_csv("data-raw/worlds_fairs.csv")
usethis::use_data(world_fairs, overwrite = TRUE)
