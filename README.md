# Bangladesh Bivariate Climate Mapping and 3D Visualization (2018–2022)

 Author: Atiq Kainan Ahmed. Email: atiqka@yahoo.com
 
## Background
 
Climate conditions across Bangladesh are characterized by substantial spatial variability. While some regions experience higher rainfall and lower temperatures due to geographic and atmospheric influences, other regions exhibit relatively warmer and drier climate patterns. Understanding these spatial differences is important for climate adaptation planning, drought and flood risk assessments, agricultural planning, environmental monitoring, and climate finance prioritization.
 
Traditional climate maps generally visualize one variable at a time, which can limit the interpretation of interactions between climatic factors. A bivariate mapping approach allows temperature and precipitation to be analyzed simultaneously, enabling users to identify areas that are:
 
- Hot and wet
- Hot and dry
- Cool and wet
- Cool and dry
- Intermediate climate zones
 
Such classifications provide a richer understanding of climate dynamics compared to single-variable maps.
 
This project demonstrates how cloud-based climate datasets available through Google Earth Engine can be combined with modern cartographic techniques in R to produce both 2D and 3D climate visualizations.
 
---
 
## Objectives
 
The primary objective of this workflow is to create a high-resolution bivariate climate map of Bangladesh that simultaneously represents:
 
- Average air temperature
- Total precipitation
 
for the period:
 
```text
January 2018 – December 2022
```
 
Specific objectives include:
 
- Retrieve long-term climate observations from Google Earth Engine.
- Process ERA5-Land temperature data.
- Process CHIRPS precipitation data.
- Harmonize spatial resolution between datasets.
- Create a bivariate climate classification.
- Produce a publication-quality 2D map.
- Generate an enhanced 3D perspective visualization.
- Export high-resolution graphics suitable for scientific publications and technical reports.
 
---

## Technical Information
 
This project was developed in **R** and utilizes **Google Earth Engine (GEE)**, **rgee**, **terra**, **sf**, **biscale**, **elevatr**, **cowplot**, and **rayshader** to create both two-dimensional and three-dimensional climate visualizations for Bangladesh.
 
The workflow integrates high-resolution temperature and precipitation datasets from Google Earth Engine and combines them into a bivariate climate surface that simultaneously visualizes climatic gradients across Bangladesh. A digital elevation model (DEM) is then used to generate a three-dimensional perspective view, providing an enhanced visualization of climate variability within the country's geographic context.
 
### Software Environment
 
| Component | Version |
|------------|------------|
| R | 4.3+ |
| rgee | Latest Stable Release |
| terra | Latest Stable Release |
| sf | Latest Stable Release |
| geodata | Latest Stable Release |
| biscale | Latest Stable Release |
| elevatr | Latest Stable Release |
| cowplot | Latest Stable Release |
| rayshader | Latest Stable Release |
| rgl | Latest Stable Release |
 
--- 



