library(tidyverse)
library(ggplot2)

library(sf)
library(tmap)
library(tmaptools)
library(leaflet)

options(scipen = 999)

data <- readr::read_csv("Data/Hospitals.csv")

countyMap_sf <- st_read("Data/cb_2018_us_county_500k/cb_2018_us_county_500k.shp", stringsAsFactors = FALSE)
countyMap_sf <- countyMap_sf %>%
  mutate(GEOID = as.numeric(GEOID))

mymap <- st_read("Data/cb_2018_us_zcta510_500k/cb_2018_us_zcta510_500k.shp", stringsAsFactors = FALSE)
mymap <- mymap %>%
  mutate(ZCTA5CE10 = as.numeric(ZCTA5CE10))

country_map_and_data <- inner_join(countyMap_sf, data)

map_and_data <- inner_join(mymap, data)

tmap_mode("view")

beds <- tm_shape(map_and_data) +
  tm_polygons("BEDS", id = "ZCTA5CE10", palette = "Greens")

countyBeds <- tm_shape(country_map_and_data)+
  tm_polygons("BEDS", id = "GEOID", palette = "Greens")
countyBeds
