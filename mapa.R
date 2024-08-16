# Napravi mapu

pacman::p_load(
  rio,           # to import data
  here,          # to locate files
  tidyverse,     # to clean, handle, and plot the data (includes ggplot2 package)
  sf,            # to manage spatial data using a Simple Feature format
  tmap,          # to produce simple maps, works for both interactive and static maps
  janitor,       # to clean column names
  OpenStreetMap, # to add OSM basemap in ggplot map
  spdep          # spatial statistics
) 

library(magick)


#library(extrafont)


shs <- st_read(here("data", "shp", "shs.shp"))

sf_use_s2(FALSE)

library(readxl)
shizofrenija <- read_excel("data/data_excel.xlsx")

baza <- left_join(shs, shizofrenija, by = "id")


baza$shizofrenijaGrupa <- as.character(baza$shizofrenija)

shizofrenija <- tm_shape(baza) + 
  tm_polygons("shizofrenijaGrupa",
              palette = c(
                "0" = "#ffffd4",
                "2" = "#fed98e", 
                "5" = "#fe9929", 
                "10" = "#d95f0e",
                "20" = "#993404"),
              legend.show = FALSE)+
  tm_layout(frame = FALSE)+
  tm_add_legend(labels = c("0", "≈ 0.2", "≈ 0.5", "≈ 1.0", "≈ 2.0"),
                col = c("#ffffd4", "#fed98e", "#fe9929", "#d95f0e", "#993404"),
                title = "Incidence per 1000")
# +tm_layout(main.title = "Rate of patients treated for schizophrenia
#   in Stenjevec state mental hospital in 1930.
#             by the patient's place of birth",
#             main.title.color = "black",
#             main.title.size = 0.75,
#             main.title.position = c('right', 'top'))


tmap_save(shizofrenija, "shizofrenija_mapa.png")


img <- image_read("shizofrenija_mapa.png")


magick::image_annotate(img, "aleksandarmedarevic.com", 
                       degrees = -30, size=75, weight=700,
                       color = "transparent",
                       location = "+670+675",
                       strokecolor = "#00000050",  boxcolor = NULL)



