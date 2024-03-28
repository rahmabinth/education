#### Preamble ####
# Purpose: Cleans the raw data recorded by the authors of "Why Does Education Reduce Crime"
# Author: Rahma Binth Mohammad
# Date: 16 February 2024
# Contact: rahma.binthmohammad@mail.utoronto.ca
# License: MIT
# Pre-requisites: Run "00-install_packages.R" and "01-download_data.R"

#### Workspace setup ####
library(tidyverse)

# Clean data #
maps_d <- read_csv("data/raw_data/reproduction_data/maps_d.csv") 

# Rename column for maps_d
maps_d_clean <- maps_d |> rename(bpl = STATEFP)

# Converting to numeric, current class is character.
maps_d_clean$bpl <- as.numeric(maps_d_clean$bpl)

#### Save data ####
write_csv(maps_d_clean, "data/analysis_data/maps_d_clean.csv")
