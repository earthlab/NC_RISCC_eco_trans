#Load packages
library(terra)
library(sp)
library(raster)

#Set path to folder
forest_path <- ".../Forest_data_mosaic"
rangeland_path <- ".../Rangeland_data" #folder where downloaded rangeland data from BM_1 script is saved

#List the raster files in each folder
forest_files <- list.files(forest_path, pattern = "\\.tif$", full.names = TRUE)
rangeland_files <- list.files(rangeland_path, pattern = "\\.tif$", full.names = TRUE)

#Loop through each year and process the rasters:
years <- 2003:2017 

for (year in years) {
  # Load the forest and rangeland rasters for the current year
  forest_raster <- raster(forest_files[grep(paste0("_", year, ".tif$"), forest_files)])
  rangeland_rasters <- stack(rangeland_files[grep(paste0("_", year, ".tif$"), rangeland_files)])
  
  # Replace -9999 values with NaN
  forest_raster[forest_raster == -9999] <- NaN

  # Reproject the forest raster to match the rangeland raster resolution
  forest_reprojected <- projectRaster(forest_raster, rangeland_rasters)
  
  # Combine the reprojected forest raster with the rangeland rasters
  combined_raster <- stack(forest_reprojected, rangeland_rasters)
  
  # Set the band names
  names(combined_raster) <- c("forest", "afgAGBrange", "pfgAGBrange", "herbaceousAGBrange")
  
  # Save the combined raster to a new file
  output_path <- paste0(".../Combined_BM_data/", "Combined_BM_", year, ".tif")
  writeRaster(combined_raster, output_path, filetype = "GTiff", overwrite = TRUE)
}
