#Import Packages
library(terra)

#Set working directory in which the tiles are located. Make sure all states end with _{year} to mosaic the files of the same years
setwd(".../Forest_Data_by_State")

#Create a function to mosaic TIFF files for a given year:
mosaic_year <- function(year) {
  # List all TIFF files for the given year
  tiff_files <- list.files(pattern = paste0("_", year, ".tif$"), recursive = TRUE, full.names = TRUE)
  
  # Read the TIFF files as SpatRaster objects
  rasters <- lapply(tiff_files, rast)
  
  # Mosaic the raster layers
  mosaic_raster <- do.call(merge, rasters)


  # Save the mosaic raster
  output_path <- paste0(".../Forest_data_mosaic/", "Forest_Mg_ha_Mosaic_", year, ".tif")
  writeRaster(mosaic_raster, output_filename, filetype = "GTiff", overwrite = TRUE)
  
  return(output_filename)
}

# Loop through the years and create mosaics:
years <- 2003:2017
for (year in years) {
  mosaic_year(year)
}
