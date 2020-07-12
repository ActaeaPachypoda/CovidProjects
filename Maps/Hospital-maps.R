library(tidyverse)
library(ggplot2)

library(sf)
library(tmap)
library(tmaptools)
library(leaflet)

options(scipen = 999)

data <- readr::read_csv("Data/Hospitals.csv")

mymap <- st_read("Data/cb_2018_us_zcta510_500k/cb_2018_us_zcta510_500k.shp", stringsAsFactors = FALSE)
mymap <- mymap %>%
  mutate(ZCTA5CE10 = as.numeric(ZCTA5CE10))

map_and_data <- inner_join(data, mymap)

testing <- ggplot(map_and_data) +
  geom_sf(aes(fill = BEDS))
testing

ggplot(map_and_data) +
  geom_sf(aes(fill = BEDS)) +
  scale_fill_gradient (low = "#56B1F7", high = "#132B43")

tm_shape(map_and_data) +
  tm_polygons("BEDS", id = "ZCTA5CE10", palette = "Greens")
