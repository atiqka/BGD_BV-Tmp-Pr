########### BGD Bivariate Temp and Precip Mapping: using CHIRPS and ERA5 - high resolution #########
### Author: Atiq Kainan Ahmed. Email: atiqka@yahoo.com ##

library(rgee)
library(geodata)
library(tidyverse)
library(sf)
library(terra)
library(biscale)
library(elevatr)
library(cowplot)
library(rayshader)
library(rgl)

# Initialize Earth Engine
ee_Initialize(email = "atiqka", project = "atiq-project-july2025", drive = TRUE)

main_dir <- getwd()
target_crs <- "EPSG:4326"

# Utility function: Load raster or download and save
load_or_download_raster <- function(filepath, download_expr) {
  if (file.exists(filepath)) {
    message("Loading existing file: ", filepath)
    terra::rast(filepath)
  } else {
    message("Downloading and saving: ", filepath)
    ras <- eval(download_expr)
    terra::writeRaster(ras, filepath, overwrite = TRUE)
    terra::rast(filepath)
  }
}

# Load Bangladesh boundary
country_sf <- geodata::gadm("BGD", level = 0, path = main_dir) %>%
  sf::st_as_sf() %>%
  sf::st_transform(target_crs)
bgd_ee <- sf_as_ee(country_sf)
region_geom <- bgd_ee$geometry()

# Download or load ERA5-Land temperature mean at approx 9 km (1000 m) scale
temp_filepath <- file.path(main_dir, "era5land_temp_2018_2022.tif")
temp_avg <- load_or_download_raster(temp_filepath, quote({
  era5 <- ee$ImageCollection("ECMWF/ERA5_LAND/HOURLY")$
    filterDate("2018-01-01", "2022-12-31")$
    select("temperature_2m")
  era5_mean <- era5$mean()$clip(region_geom)
  ee_as_rast(image = era5_mean, region = region_geom, scale = 1000)  # 1 km scale ~ native resolution ~ 9 km
}))

# Download or load CHIRPS precipitation sum at approx 5 km (500 m) scale
prec_filepath <- file.path(main_dir, "chirps_precip_2018_2022.tif")
prec_sum <- load_or_download_raster(prec_filepath, quote({
  chirps <- ee$ImageCollection("UCSB-CHG/CHIRPS/DAILY")$
    filterDate("2018-01-01", "2022-12-31")$
    select("precipitation")
  chirps_sum <- chirps$sum()$clip(region_geom)
  ee_as_rast(image = chirps_sum, region = region_geom, scale = 500)  # 500 m scale ~ 5 km native res
}))

# Resample precipitation to temperature raster's grid
prec_sum_resampled <- terra::resample(prec_sum, temp_avg, method = "bilinear")

# Stack temperature and precipitation
temp_prec <- c(temp_avg, prec_sum_resampled)
names(temp_prec) <- c("temperature", "precipitation")

# Crop to Bangladesh boundary
temp_prec_country <- terra::crop(temp_prec, country_sf, mask = TRUE)

# DEM terrain from elevatr at zoom level 8 (approx 30 m)
dem_filepath <- file.path(main_dir, "dem_elevatr_2018_2022.tif")
if (file.exists(dem_filepath)) {
  message("Loading existing DEM: ", dem_filepath)
  dem <- terra::rast(dem_filepath)
} else {
  message("Downloading DEM with elevatr...")
  dem_r <- elevatr::get_elev_raster(locations = country_sf, z = 8, clip = "locations") |> terra::rast()
  dem <- terra::crop(dem_r, country_sf, mask = TRUE)
  terra::writeRaster(dem, dem_filepath, overwrite = TRUE)
}

# Resample climate rasters to DEM resolution and project
temp_prec_resampled_dem <- terra::resample(temp_prec_country, dem, method = "bilinear")
temp_prec_projected <- terra::project(temp_prec_resampled_dem, target_crs)
temp_prec_df <- as.data.frame(temp_prec_projected, xy = TRUE)

# Create bivariate class map for 2D plotting
breaks <- biscale::bi_class(temp_prec_df, x = temperature, y = precipitation, style = "fisher", dim = 3)
pal <- "DkBlue"

theme_for_the_win <- function() {
  theme_minimal() +
    theme(
      axis.title = element_blank(),
      plot.background = element_rect(fill = "white", color = NA),
      plot.title = element_text(color = "grey10", hjust = 0.5, face = "bold", vjust = -1),
      plot.subtitle = element_text(hjust = 0.5, vjust = -1),
      plot.caption = element_text(size = 9, color = "grey20", hjust = 0.5, vjust = 1),
      plot.margin = unit(c(0,0,0,0), "lines")
    )
}

map <- ggplot(breaks) +
  geom_raster(aes(x = x, y = y, fill = bi_class), show.legend = TRUE) +
  biscale::bi_scale_fill(pal = pal, dim = 3, flip_axes = TRUE) +
  labs(
    title = "BANGLADESH: Temperature and Precipitation (2018–2022)",
    subtitle = "Average temperature and precipitation",
    caption = "Source: ERA5-Land & CHIRPS via Earth Engine | Curated by: Atiq K. Ahmed"
  ) +
  coord_sf(crs = target_crs) +
  theme_for_the_win()

legend <- biscale::bi_legend(
  pal = pal, flip_axes = TRUE, dim = 3,
  xlab = "Temperature (°C)", ylab = "Precipitation (mm)", size = 8
)

full_map <- cowplot::ggdraw() +
  cowplot::draw_plot(map, 0, 0, 1, 1) +
  cowplot::draw_plot(legend, 0.05, 0.13, 0.25, 0.25)

print(full_map)

ggsave(file.path(main_dir, "bangladesh_bivariate_2d_2018_2022.png"),
       full_map, width = 7, height = 7, dpi = 600)

# Prepare terrain elevation plot for rayshader
dem_df <- dem %>%
  terra::project(target_crs) %>%
  as.data.frame(xy = TRUE, na.rm = TRUE)
names(dem_df)[3] <- "dem"
dem_map <- ggplot(dem_df, aes(x = x, y = y, fill = dem)) +
  geom_raster() +
  scale_fill_gradientn(colors = "white") +
  guides(fill = "none") +
  labs(
    title = "BANGLADESH: Terrain Elevation",
    subtitle = "SRTM DEM (~30m resolution)",
    caption = "Source: USGS SRTM | Curated by: Atiq K. Ahmed"
  ) +
  coord_sf(crs = target_crs) +
  theme_for_the_win() +
  theme(legend.position = "none")

# Render 3D plot with rayshader
rgl::open3d()
rgl::clear3d()
rayshader::plot_gg(
  ggobj = full_map,
  ggobj_height = dem_map,
  width = 7,
  height = 7,
  windowsize = c(800, 800),
  scale = 150,
  shadow = TRUE,
  shadow_intensity = 1,
  phi = 87,
  theta = 0,
  zoom = 0.56,
  multicore = TRUE
)

rayshader::render_camera(zoom = 0.6)

# Save 3D snapshot
rayshader::render_snapshot(
  filename = file.path(main_dir, "bangladesh_bivariate_3d_2018_2022.png"),
  clear = TRUE
)

message("All steps completed successfully.")

#end script#
