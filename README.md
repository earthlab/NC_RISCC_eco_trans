# NC_RISCC_ecosystem_transformations

Workflow:
We use a combination of tools. 
1. For long running/batch tasks, we used Python (+ Google Earth Engine (GEE) Python SDK). 
2. For final visualization tasks, Google Earth Engine was used.


1. Pull Raw GEDI L4A data (in CSVs) for a pre-defined region (In our case we pulled L4A data for North Central Region's Forests)
2. Convert the pulled GEDI L4A data to a workable shapefile format. Upload this shape file to GEE. Subsequent code will require the .shp file present on your GEE account
3. Now we have a .shp file of pointwise AGBD values along with other GEDI L4A variables (solar elevation, l4_quality_flag, degrade_flag etc.). We will now map these pointwise GEDI values (~25m) to their corresponding MODIS data (~500m) and NASA DEM data (~30m). 
4. We now have the mapped data between GEDI and Modis Data/Indices. This data is actually region/patch, hence we have thousands of CSV files at this point. Merge these individual CSVs to one single CSV for convinience
5. We will now start modelling our data. The first part of modelling is to find "How many GEDI L4A pixels are worth considering per MODIS pixel?" and "What are the most important features?"
6. 
