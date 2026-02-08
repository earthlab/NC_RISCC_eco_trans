# Ecosystem Transformations

Workflow:
We use a combination of tools. 
- For long running/batch tasks, we used Python (+ Google Earth Engine (GEE) Python SDK) and R scripts
- For final visualization tasks, Google Earth Engine was used

<div align="center">
    <img src="img/NC_RISCC_Workflow_figure.png" alt="Workflow Diagram">
</div>

----

The data was processed in two phases. The first phase led to the forest biomass prediction rasters. The second phase resulted in the rangeland biomass prediction rasters as well as an estimation of the total biomass. The steps for each phase are described below. 

<h1>Phase 1 - Forest Biomass Prediction:</h1>

1. Pull Raw GEDI L4A data (in CSVs) for a pre-defined region (In our case we pulled L4A data for North Central Region's Forests) - [Download_GEDI_L4A.ipynb](https://github.com/earthlab/NC_RISCC_eco_trans/blob/main/notebooks/Download_GEDI_L4A.ipynb)
2. Convert the pulled GEDI L4A data to a workable shapefile format. Upload this shape file to GEE. Subsequent code will require the .shp file present on your GEE account - [Convert_And_Merge_SHP.ipynb](https://github.com/earthlab/NC_RISCC_eco_trans/blob/main/notebooks/Convert_And_Merge_SHP.ipynb)
3. Now we have a .shp file of pointwise AGBD values along with other GEDI L4A variables (solar elevation, l4_quality_flag, degrade_flag etc.). We will now map these pointwise GEDI values (~25m) to their corresponding MODIS data (~500m) and NASA DEM data (~30m). - [Map_Gedi_Modis.ipynb](https://github.com/earthlab/NC_RISCC_eco_trans/blob/main/notebooks/Map_Gedi_Modis.ipynb)
4. We now have the mapped data between GEDI and Modis Data/Indices. This data is actually region/patch, hence we have thousands of CSV files at this point. Merge these individual CSVs to one single CSV for convenience 
5. We will now start modelling our data. The first part of modelling is to find "How many GEDI L4A pixels are worth considering per MODIS pixel?" and "What are the most important features in order to predict biomass?" and "What is the ideal set of hyperparameters for our model?" - ([Feature_SelectionBulk_Overlap.ipynb](https://github.com/earthlab/NC_RISCC_eco_trans/blob/main/notebooks/Feature_SelectionBulk_Overlap.ipynb), [HyperparameterOpt_RF.ipynb](https://github.com/earthlab/NC_RISCC_eco_trans/blob/main/notebooks/HyperparameterOpt_RF.ipynb), [Train_RF.ipynb](https://github.com/earthlab/NC_RISCC_eco_trans/blob/main/notebooks/Train_RF.ipynb))
6. We are now ready for prediction. Download the state wise data - [Download_Statewise_MODIS.ipynb](https://github.com/earthlab/NC_RISCC_eco_trans/blob/main/notebooks/Download_Statewise_MODIS.ipynb) We also share the data via [Drive Folder](https://drive.google.com/drive/folders/1dGYQBceHyjFRh2XX7h6wn9ZqbfOc4PZm)
7. Now predict on state wise data with - [Statewise_Prediction.ipynb](https://github.com/earthlab/NC_RISCC_eco_trans/blob/main/notebooks/Statewise_Prediction.ipynb)
8. The predicted biomass' raster be found statewise at [Drive Folder](https://drive.google.com/drive/folders/1gs3lxppopTk1mLWcP2B_IVT3IBpd5qYc)

<h1>Phase 2 - Combining Rangeland and Forest Biomass data:</h1>

<i> See [Methods_Biomass_Dataset.docx](docs/Methods_Biomass_Dataset.docx) for detailed methods and references </i>
1. Download the rangeland biomass data from Google Earth Engine - [BM_1_Download_RAP_data.ipynb](notebooks/BM_1_Download_RAP_data.ipynb)
2. Mosaic the state-level forest biomass raster files (from the [Steps - Forest Biomass Prediction](#Steps_-_Forest_Biomass_Prediction) section) to create a raster for each year of the whole study area - [BM_2_Mosaic_forest_data.R](R_Scripts/BM_2_Mosaic_forest_data.R)
3. Reproject the forest biomass data and combine with the rangeland biomass data - [BM_3_combine_forest_rangeland.R](R_Scripts/BM_3_combine_forest_rangeland.R)
4. Compute the total biomass to generate annual raster files with 3 bands (Total BM, Forest BM, Rangeland BM) - [BM_4_combine_total_BM.R](R_Scripts/BM_4_combine_total_BM.R)
5. Stack the <i>total biomass</i> raster bands of each year to generate a single raster file with bands of <i>total biomass per year</i> - [BM_4_combine_total_BM.R](R_Scripts/BM_4_combine_total_BM.R)

<h1>Phase 3 - Predicting Ecosystem Transitions:</h1>
1. Used already transformed pixels and their vegetation index time series to detect the break points and their lead time if any as transformation indicators.
2. Added climate variables including precipitation, temperature (time series for precipitation temperature data), fire risk and grass invasion risk data to evaluate the impact of these drivers on incrasing/decreasing transformations
3. Added censored non-transformed data with their vegetation inex time series, climate, dire, and invasion driver variables to model the vulnerability for transformations within next 10-15 years.
4. Generated the maps of pixel basis (500 m) vuolnerability for transformation for each state.

<h1>Phase 4 - Predicting Biomass Change in Transition Areas:</h1>

1. Resample the biomass data to the transition data resolution for each state in the North Central Region - [1_Biomass_Transition_Resample_States.ipynb](notebooks/1_Biomass_Transition_Resample_States.ipynb)
2. Calculate the biomass up to 3 years before the tansition took place and compare that to the 3 most recent years. Caluclate the variance of these before-and-after biomass values and determine if the change is within or outside of this variance. - [2_Biomass_Transition_Analysis_States.ipynb](notebooks/2_Biomass_Transition_Analysis_States.ipynb)
3. Clip the output from the previous step to the state boundaries - [3_Biomass_Transition_Output_Cleaning.ipynb](notebooks/3_Biomass_Transition_Output_Cleaning.ipynb) 
