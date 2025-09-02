library(terra)

# Define the folder containing the raster files
folder_path <- ".../Total_BM_data"

# List all raster files in the folder
raster_files <- list.files(folder_path, pattern = "\\.tif$", full.names = TRUE)

# Sort the files to ensure they are in chronological order
raster_files <- sort(raster_files)

# Read the first band of each raster and store them in a list
bands <- lapply(raster_files, function(file) {
  rast(file)[[1]]
})

# Stack the bands into a single raster
stacked_bands <- rast(bands)

# Set the names for the bands
names(stacked_bands) <- c("2003", "2004", "2005","2006","2007","2008","2009","2010", "2011","2012","2013","2014","2015","2016","2017")

# Define the output file path
output_file <- ".../Total_BM_stacked.tif"

# Write the stacked bands to a new raster file
writeRaster(stacked_bands, output_file, filetype = "GTiff", overwrite = TRUE)

print(paste("Successfully created stacked raster:", output_file))
