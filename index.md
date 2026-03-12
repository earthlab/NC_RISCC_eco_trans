
![Grass Invasion after fires](img/unnamed.jpg)

Forest to grass or shrubland transitions are emerging as a major ecological risk across north central U.S. forest systems, particularly in dry and disturbance prone forests of Montana, Wyoming, and Colorado and in the fragmented forest - grassland ecotones extending from North Dakota to Kansas. The literature shows that warming, drought, high severity fire, and regeneration failure can push these systems beyond recovery thresholds, leading to persistent nonforest states. Because forests typically store more carbon than shrublands or grasslands, these transitions can reduce long term carbon storage, weaken regional carbon sinks, and alter ecosystem resilience. Quantifying where, how fast, and under what conditions these transitions occur, where are the areas vulnerable for near future transformations, and what is the impact on aboveground carbon storage are therefore critical for carbon accounting, climate adaptation, and land management.

## Study Area
![Study Area](img/study_area.png)

## Methods
![Workflow](img/NC_RISCC_Workflow_figure.png)

The study consists of four phases.

### Phase 1 - Forest Biomass Prediction:
Develop a time series of forest biomass (500 m resolution) using GEDI footprint based biomass density data and MODIS vegetation index time series. The full workflow and the codes used for this phase can be found [here](notebooks). The resulsts are provided per state time series from 2003-2017.
The predicted biomass' raster be found statewise at Drive Folder

### Phase 2 - Combining Rangeland and Forest Biomass data:
See Methods_Biomass_Dataset.docx for detailed methods and references

Download the rangeland biomass data from Google Earth Engine - BM_1_Download_RAP_data.ipynb
Mosaic the state-level forest biomass raster files (from the Steps - Forest Biomass Prediction section) to create a raster for each year of the whole study area - BM_2_Mosaic_forest_data.R
Reproject the forest biomass data and combine with the rangeland biomass data - BM_3_combine_forest_rangeland.R
Compute the total biomass to generate annual raster files with 3 bands (Total BM, Forest BM, Rangeland BM) - BM_4_combine_total_BM.R
Stack the total biomass raster bands of each year to generate a single raster file with bands of total biomass per year - BM_4_combine_total_BM.R

### Phase 3 - Predicting Ecosystem Transitions:
1. Used already transformed pixels and their vegetation index time series to detect the break points and their lead time if any as transformation indicators.
Added climate variables including precipitation, temperature (time series for precipitation temperature data), fire risk and grass invasion risk data to evaluate the impact of these drivers on incrasing/decreasing transformations

Added censored non-transformed data with their vegetation inex time series, climate, dire, and invasion driver variables to model the vulnerability for transformations within next 10-15 years.

Generated the maps of pixel basis (500 m) vuolnerability for transformation for each state.

### Phase 4 - Predicting Biomass Change in Transition Areas:
Resample the biomass data to the transition data resolution for each state in the North Central Region - 1_Biomass_Transition_Resample_States.ipynb
Calculate the biomass up to 3 years before the tansition took place and compare that to the 3 most recent years. Caluclate the variance of these before-and-after biomass values and determine if the change is within or outside of this variance. - 2_Biomass_Transition_Analysis_States.ipynb
Clip the output from the previous step to the state boundaries - 3_Biomass_Transition_Output_Cleaning.ipynb

## Findings


### References

### Funding

### Team


