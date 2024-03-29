#### Preamble ####
# Purpose: Replicated graphs from "Why Does Education Reduce Crime?" (Bell et al. 2022)
# Author: Rahma Binth Mohammad
# Date: 16 February 2024
# Contact: rahma.binthmohammad@mail.utoronto.ca
# License: MIT
# Pre-requisites: Run the "00-install_packages.R", 01-download_data.R", and the "02-data_cleaning.R" file. 

#### Workspace setup ####
library(tidyverse)
library(haven)
library(ggplot2)
library(dplyr)
library(sf)
library(gridExtra)

#### Figure 1 Replication ####

#### Load data ####
crime_data <- read_csv("data/raw_data/reproduction_data/Figure_1_data.csv") 

# Calculate cumulative_arrest for the male arrestsper 1000 population
crime_data <- crime_data %>%
  group_by(agegroup, crime_type) %>%
  summarise(cumulative_arrest = sum(arrest_rate) * 1000) %>%
  ungroup()

# Reorder levels of crime_type, starting with the violent crimes on the bottom
crime_data <- crime_data %>%
  mutate(crime_type = factor(crime_type, levels = c(3, 2, 1)))

#Plots age against cumulative arrests
ggplot(crime_data, aes(x = as.factor(agegroup), y = cumulative_arrest, 
                       fill = factor(crime_type))) +
  geom_bar(stat = "identity", position = "stack", width = 0.8) + #bar graph
  scale_fill_manual(values = c("black", "lightblue", "darkred"), #colours
                    labels = c("Drugs", "Property", "Violent")) + #legend
  labs(x = "Age", y = "Arrest Rate (Per 1000 Population)", fill = NULL, 
       title = "Cumalitive Arrests By Age and Crime Type") + #titles
  scale_x_discrete(labels = c("15", "16", "17", "18", "19", "20", "21", "22", 
                              "23", "24", "25-29", "30-34", "35-39")) + #labels
  scale_y_continuous(breaks = seq(0, 100, by = 20)) + # y-axis breaks
  theme_minimal() +
  theme(legend.position = "bottom", #legend position
        axis.text.x = element_text(angle = 0, hjust = 0.5), #Centers axis
        plot.title = element_text(hjust = 0.5), #Centers title
        panel.grid.major = element_blank(),  #Removes major grid lines
        panel.grid.minor = element_blank())  #Removes minor grid lines

#### Figure 2 Replication ####

#### Load data ####
maps_d_clean <- read_csv("data/analysis_data/maps_d_clean.csv")
dropout_age <- read_csv("data/raw_data/reproduction_data/dropout_age.csv")

#Rename coloumn for dropout_age
names(dropout_age)[names(dropout_age) == "STATEFP"] <- "bpl"

# Load US state boundary data
us_states <- map_data("state")

#Covert to spatial data frama
maps_d_sf <- st_as_sf(maps_d_clean, coords = c("x_c", "y_c"))

# Filter dropout_age for 1980 and 2010
dropout_age_1980 <- filter(dropout_age, year == 1980)
dropout_age_2010 <- filter(dropout_age, year == 2010)

# Join the datasets mapd_d_sf and dropout_age_1980, as well as dropout_age_2010
maps_d_sf_1980 <- left_join(maps_d_sf, dropout_age_1980, by = c("bpl"))
maps_d_sf_2010 <- left_join(maps_d_sf, dropout_age_2010, by = c("bpl"))

#Convert the coloumn values to contain all lowercase values to match with 
# a us_states column
maps_d_sf_1980$NAME <- tolower(maps_d_sf_1980$NAME)
us_states_1980 <- left_join(us_states, maps_d_sf_1980, 
                            by =  c("region" = "NAME"))

maps_d_sf_2010$NAME <- tolower(maps_d_sf_2010$NAME)
us_states_2010 <- left_join(us_states, maps_d_sf_2010, 
                            by =  c("region" = "NAME"))

# Plots the map boundary
base_map <- ggplot() +
  geom_polygon(data = us_states_1980, aes(x = long, y = lat, group = group), 
               fill ="white", color = "grey") +
  coord_map() +
  theme_minimal() +
  labs(x = "Longitude", y = "Latitude") +
  ggtitle("Map of US States")

#Set the colours for the different ages
colours <- c("14" = "aquamarine2", "15" = "seagreen", "16" = "aquamarine3", 
             "17" = "aquamarine4", "18" = "chartreuse4", "NA" = "white")

# Plot dropout age data within state boundaries
data_map_1980 <- ggplot() +
  geom_sf(data = maps_d_sf_1980, aes(fill = as.factor(dropage)), size = 2) +
  geom_polygon(data = us_states_1980, aes(x = long, y = lat, group = group, 
                                          fill = as.factor(dropage)), 
               color = "grey") +
  theme_void() +
  theme(plot.title = element_text(hjust = 0.4)) + 
  scale_fill_manual(values = colours, 
                    guide = "legend", name = "Dropout Age  ",
                    na.value = "white") +
  labs(title = "Dropout Age by State (1980)") +
  coord_sf(xlim = c(-130, -60), ylim = c(25, 50))

# Plot dropout age data within state boundaries
data_map_2010 <- ggplot() +
  geom_sf(data = maps_d_sf_2010, aes(fill = as.factor(dropage)), size = 2) +
  geom_polygon(data = us_states_2010, aes(x = long, y = lat, group = group, 
                                          fill = as.factor(dropage)), 
               color = "grey") +
  theme_void() +
  theme(plot.title = element_text(hjust = 0.4)) + 
  scale_fill_manual(values = colours, 
                    guide = "legend", name = "Dropout Age  ",
                    na.value = "white") +
  labs(title = "Dropout Age by State (2010)") +
  coord_sf(xlim = c(-130, -60), ylim = c(25, 50))

# Show the combined plot
figure2 <- grid.arrange(data_map_1980, data_map_2010, ncol = 1)
invisible(print(figure2))

#### Figure 6 Replication ####

#### Load data ####
crime_data2 <- read_csv("data/raw_data/reproduction_data/figure3_data.csv") 

# Calculate arrest rates
crime_data2$arrest_rate_base <- exp(crime_data2$base_age)
crime_data2$arrest_rate_new <- exp(crime_data2$base_age + crime_data2$b_age)

# Plotting
# Total
total_fig <- ggplot(crime_data2[crime_data2$crime == 4, ], aes(x = age)) +
  geom_line(aes(y = arrest_rate_base), stat = "identity", color = "aquamarine2", alpha = 1) +
  geom_line(aes(y = arrest_rate_new), stat = "identity", color = "chartreuse4", alpha = 1) +
  labs(x = "Age", y = "Estimated Arrest Rates", title = "Total") +
  scale_x_continuous(breaks = seq(15, 24, by = 1)) +
  scale_y_continuous(limits = c(0.04, 0.12), breaks = seq(0.04, 0.12, by = 0.02)) +
  theme_bw()

# Violent
violent_fig <- ggplot(crime_data2[crime_data2$crime == 1, ], aes(x = age)) +
  geom_line(aes(y = arrest_rate_base), stat = "identity", color = "hotpink", alpha = 1) +
  geom_line(aes(y = arrest_rate_new), stat = "identity", color = "darkred", alpha = 1) +
  labs(x = "Age", y = "Estimated Arrest Rates", title = "Violent") +
  scale_x_continuous(breaks = seq(15, 24, by = 1)) +
  scale_y_continuous(limits = c(0, 0.032), breaks = seq(0, 0.032, by = 0.008)) +
  theme_bw()

# Property
property_fig <- ggplot(crime_data2[crime_data2$crime == 2, ], aes(x = age)) +
  geom_line(aes(y = arrest_rate_base), stat = "identity", color = "deepskyblue", alpha = 1) +
  geom_line(aes(y = arrest_rate_new), stat = "identity", color = "blue", alpha = 1) +
  labs(x = "Age", y = "Estimated Arrest Rates", title = "Property") +
  scale_x_continuous(breaks = seq(15, 24, by = 1)) +
  scale_y_continuous(limits = c(0, 0.06), breaks = seq(0, 0.06, by = 0.015)) +
  theme_bw()

# Drugs
drugs_fig <- ggplot(crime_data2[crime_data2$crime == 3, ], aes(x = age)) +
  geom_line(aes(y = arrest_rate_base), stat = "identity", color = "gray45", alpha = 1) +
  geom_line(aes(y = arrest_rate_new), stat = "identity", color = "black", alpha = 1) +
  labs(x = "Age", y = "Estimated Arrest Rates", title = "Drugs") +
  scale_x_continuous(breaks = seq(15, 24, by = 1)) +
  scale_y_continuous(limits = c(0, 0.036), breaks = seq(0, 0.036, by = 0.009)) +
  theme_bw()

total_n_violent <- grid.arrange(total_fig, violent_fig, ncol = 2)
property_n_drugs <- grid.arrange(property_fig, drugs_fig, ncol = 2)

# Arrange top and bottom rows
figure3 <- grid.arrange(total_n_violent, property_n_drugs, nrow = 2)





