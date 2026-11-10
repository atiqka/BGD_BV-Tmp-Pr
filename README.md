# Bangladesh Bivariate Climate Mapping and 3D Visualization (2018–2022)

Author: Atiq Kainan Ahmed. Email: atiqka@yahoo.com

The output map is shown here. https://github.com/atiqka/BGD_BV-Tmp-Pr/blob/main/BGD_Bivariate-tmp-pr.png

## Overview
 
Climate conditions across Bangladesh are characterized by substantial spatial variability. While some regions experience higher rainfall and lower temperatures because of geographic and atmospheric influences, other regions have warmer, drier climate patterns. Understanding these spatial differences is important for climate adaptation planning, drought and flood risk assessments, agricultural planning, environmental monitoring, and climate finance prioritization.
 
Traditional climate maps generally visualize one variable at a time, which can limit the interpretation of interactions between climatic factors. A bivariate mapping approach allows temperature and precipitation to be analyzed simultaneously, enabling users to identify areas that are:
 
- Hot and wet
- Hot and dry
- Cool and wet
- Cool and dry
- Intermediate climate zones
 
Such classifications provide a richer understanding of climate dynamics compared to single-variable maps. This exercise demonstrates how cloud-based climate datasets available through Google Earth Engine can be combined with modern cartographic techniques in R to produce both 2D and 3D climate visualizations. 

We acknowledge and thank Milos for the initial approach developed for bivariate modeling. This exercise builds on that initial approach and is curated by the author with contextualized datasets, tapping other datasets, variations, localization, and a curated methodology for applications. 
 
---
 
## Objectives
 
The primary objective of this workflow is to create a high-resolution bivariate climate map of Bangladesh that simultaneously represents:
 
- Average air temperature
- Total precipitation
 
for the period:
 
```text
January 2018 – December 2022 (duration was aligned with the period of the latest DHS, BDHS 2022).
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

### Data Sources

This project integrates multiple globally recognized geospatial and climate datasets through Google Earth Engine and complementary open-source spatial data repositories. The datasets were selected based on their scientific credibility, global coverage, spatial resolution, temporal consistency, and widespread use within climate, environmental, and disaster risk research. Data sources and details are as below. 

## 1. ERA5-Land Climate Reanalysis

ERA5-Land is a global land-surface reanalysis dataset produced by the European Centre for Medium-Range Weather Forecasts (ECMWF). It provides a physically consistent reconstruction of historical climate conditions by combining numerical weather models with observational data. ERA5-Land is specifically designed to improve land-surface representation relative to the standard ERA5 reanalysis. 

Dataset Used: ECMWF/ERA5_LAND/HOURLY
Variable: temperature_2m
The variable represents near-surface air temperature measured approximately two meters above ground level.
Temporal Coverage: January 1950 – Present
Temporal Resolution: Hourly
Spatial Resolution: 0.1° × 0.1° (~9 km native resolution)
Data Provider: European Centre for Medium-Range Weather Forecasts (ECMWF), Copernicus Climate Change Service (C3S)

---

## 2. CHIRPS Precipitation

Climate Hazards Group InfraRed Precipitation with Stations (CHIRPS) is a long-term quasi-global rainfall dataset developed by the Climate Hazards Center at the University of California, Santa Barbara. CHIRPS combines satellite imagery with ground-based station observations to produce gridded precipitation estimates suitable for drought monitoring, climate assessment, and hydrological analysis. 

Dataset Used: UCSB-CHG/CHIRPS/DAILY
Variable:precipitation, daily precipitation estimates derived from infrared satellite observations merged with in-situ station measurements.
Temporal Coverage: 1981 – Present
Temporal Resolution: Daily
Spatial Resolution: 0.05°(~5.6 km)
Data Provider: Climate Hazards Group (CHG), University of California, Santa Barbara (UCSB)

---

## 3. Administrative Boundaries

National boundaries for Bangladesh were obtained using the GADM database through the R package geodata. GADM is one of the most widely used global administrative boundary databases and provides harmonized boundary datasets for countries and subnational administrative units worldwide. The current database contains hundreds of thousands of administrative areas globally. 

Dataset: geodata::gadm("BGD", level = 0)
Administrative Level: ADM0 (National Boundary)
Data Provider: GADM Database of Global Administrative Areas

---

## 4. Digital Elevation Model (DEM)

Terrain elevation data are obtained using the elevatr package, which accesses Shuttle Radar Topography Mission (SRTM) elevation products. The SRTM mission was jointly conducted by NASA and the National Geospatial-Intelligence Agency (NGA) and produced one of the most widely used global digital elevation datasets. SRTM data provide near-global land-surface elevation coverage at approximately 30-meter resolution. 

Dataset: SRTM Digital Elevation Model
Resolution: 1 Arc-Second (~30 meters)
Coverage:  Global land surface between 60°N and 56°S
Data Provider: NASA, United States Geological Survey (USGS), National Geospatial-Intelligence Agency (NGA)

---

## License

MIT License

Copyright (c) 2025 Atiq Kainan Ahmed.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
