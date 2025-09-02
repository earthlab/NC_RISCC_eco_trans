# Load necessary libraries
library(terra)
library(sp)
library(raster)

# Define the input and output directories
input_dir <- ".../Combined_BM_data"
output_dir <- ".../Total_BM_data"

# Create the output directory if it doesn't exist
if (!dir.exists(output_dir)) {
  dir.create(output_dir)
}


# Function to replace NaN values with 0
replace_nan <- function(x) {
  x[is.nan(x)] <- 0
  return(x)
}


# Loop through the years
for (year in 2003:2017) {
  # Construct the file path
  file_path <- file.path(input_dir, paste0("Combined_BM_", year, ".tif"))
  
  # Read the raster file
  r <- rast(file_path)
  
  # Extract the bands
  band1 <- r[[1]]
  band4 <- r[[4]]
  
  # Apply the function to handle NaN values
  band1 <- app(band1, replace_nan)
  
  # Create the new band (sum of band 1 and band 4)
  new_band <- band1 + band4
  
  # Combine the bands into a new raster
  new_raster <- c(new_band, band1, band4)
  
  # Set the names for the bands
  names(new_raster) <- c("Total_BM", "Forest_BM", "Rangeland_BM")
  
  # Define the output file path
  output_file_path <- file.path(output_dir, paste0("Total_BM_", year, ".tif"))
  
  # Write the new raster to the output directory
  writeRaster(new_raster, output_file_path, overwrite = TRUE)
}

cat("Processing complete. New raster files saved in:", output_dir)
