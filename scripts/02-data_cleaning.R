#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rahma Binth Mohammad
# Date: 
# Contact: rahma.binthmohammad@mail.utoronto.ca
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)

#### Clean data ####
maps_d <- read_csv("data/raw_data/reproduction_data/maps_d.csv") 

# Rename column for maps_d
maps_d_clean <- maps_d |> rename(bpl = STATEFP)

# Converting to numeric, current class is character.
maps_d_clean$bpl <- as.numeric(maps_d_clean$bpl)

#### Save data ####
write_csv(maps_d_clean, "data/analysis_data/analysis_data.csv")
