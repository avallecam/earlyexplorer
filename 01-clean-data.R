
# Load packages -----------------------------------------------------------

library(tidyverse)
library(cleanepi)

dat <- rio::import(here::here("data","raw-data","simulated_ebola_2.csv")) %>% 
  as_tibble()

dat

# load data dictionary (collapse this) ----------------------------------------------------

# Read this dictionary and activate function cleanepi::clean_using_dictionary()
dat_dictionary <- tibble::tribble(
  ~options,  ~values,     ~grp, ~orders,
  "1",   "male", "gender",      1L, # remove this line: how this affects the code downstream?
  "2", "female", "gender",      2L,
  "M",   "male", "gender",      3L,
  "F", "female", "gender",      4L,
  "m",   "male", "gender",      5L,
  "f", "female", "gender",      6L
)

dat_dictionary

# challenge ---------------------------------------------------------------

#' task: 
#' 1. run the whole script. Did all problems were solved? or only some of them?
#' 2. Modify one line #47: Change `"2016-12-01"` to `"2014-12-01"`. What changes?
#' 3. Modify one line #54: Activate `cleanepi::clean_using_dictionary()`. What changes?

dat %>%
  cleanepi::standardize_column_names() %>% 
  cleanepi::remove_constants() %>% 
  cleanepi::remove_duplicates() %>% 
  cleanepi::replace_missing_values(na_strings = "") %>% 
  cleanepi::check_subject_ids(
    target_columns = "case_id",
    range = c(0, 15000)
  ) %>% 
  cleanepi::standardize_dates(
    target_columns = c("date_onset"), # challenge: add "date_sample" to the vector
    timeframe = c(
      as.Date("2014-01-01"), as.Date("2016-12-01") # challenge: from year 2016 to 2015
    ) 
  ) %>% 
  cleanepi::convert_to_numeric(
    target_columns = "age"
  ) %>% 
  # cleanepi::clean_using_dictionary(dictionary = dat_dictionary) %>% # challenge: activate this
  # cleanepi::print_report() # challenge: activate this
  identity()
