#### Preamble ####
# Purpose: Downloads and saves the data from the replication package provided 
# by the authors
# Author: Rahma Binth Mohammad
# Date: 16 February 2024
# Contact: rahma.binthmohammad@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(haven)

#### Download data ####
figure1_data <- read_dta("data/raw_data/replication_data/Figure_1_data.dta")
dropout_age <- read_dta("data/raw_data/replication_data/dropout_age_1980_2010.dta")
maps_d <- read_dta("data/raw_data/replication_data/maps_d.dta")
figure3_data <- read_dta("data/raw_data/replication_data/Figures_5_6_data.dta")

#### Save data ####
write.csv(figure1_data, "data/raw_data/reproduction_data/figure1_data.csv") 
write.csv(dropout_age, "data/raw_data/reproduction_data/dropout_age.csv") 
write.csv(maps_d, "data/raw_data/reproduction_data/maps_d.csv") 
write.csv(figure3_data, "data/raw_data/reproduction_data/figure3_data.csv") 
