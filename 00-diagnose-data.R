
# Load packages -----------------------------------------------------------

library(tidyverse)

dat <- rio::import(here::here("data","raw-data","simulated_ebola_2.csv")) %>% 
  as_tibble()


# challenge ---------------------------------------------------------------

#' task: list all the cleaning issues you identify in the data

dat