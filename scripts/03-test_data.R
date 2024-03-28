#### Preamble ####
# Purpose: Tests the data from the reproduction package from the paper "Why Does Education Reduce Crime"
# Author: Rahma Binth Mohammad
# Date: 16 February 2024
# Contact: rahma.binthmohammad@mail.utoronto.ca
# License: MIT
# Pre-requisites: Run "00-install_packages.R", "01-download_data.R", and "02-data_cleaning.R"
# Any other information needed? This file is just to test the column classes. 


#### Workspace setup ####
library(tidyverse)
library(haven)

# Read the data #
figure1_data <- read_csv("data/raw_data/reproduction_data/figure1_data.csv") 
dropout_age <- read_csv("data/raw_data/reproduction_data/dropout_age.csv") 
maps_d <- read_csv("data/raw_data/reproduction_data/maps_d.csv") 
figure3_data <- read_csv("data/raw_data/reproduction_data/figure3_data.csv") 

#### Test data ####
figure1_data$crime_type |> class() == "numeric"
figure1_data$agegroup |> class() == "numeric"
figure1_data$arrest_rate |> class() == "numeric"

dropout_age$year |> class() == "numeric"
dropout_age$bpl |> class() == "numeric"
dropout_age$dropage |> class() == "numeric"

maps_d$id |> class() == "numeric"
maps_d$x_c |> class() == "numeric"
maps_d$y_c |> class() == "numeric"
maps_d$STATEFP |> class() == "character"
maps_d$STATENS |> class() == "character"
maps_d$AFFGEOID |> class() == "character"
maps_d$GEOID |> class() == "character"
maps_d$STUSPS |> class() == "character"
maps_d$NAME |> class() == "character"
maps_d$LSAD |> class() == "character"
maps_d$ALAND |> class() == "numeric"
maps_d$AWATER |> class() == "numeric"

figure3_data$age |> class() == "numeric"
figure3_data$b_age |> class() == "numeric"
figure3_data$se_age |> class() == "numeric"
figure3_data$base_age |> class() == "numeric"
figure3_data$crime |> class() == "numeric"
figure3_data$crime_name |> class() == "character"
figure3_data$b_age_low |> class() == "numeric"
figure3_data$b_age_upper |> class() == "numeric"


















