# Bangladesh Bivariate Climate Mapping and 3D Visualization (2018–2022)

Author: Atiq Kainan Ahmed. Email: atiqka@yahoo.com


## Background
 
Climate conditions across Bangladesh are characterized by substantial spatial variability. While some regions experience higher rainfall and lower temperatures because of geographic and atmospheric influences, other regions have warmer, drier climate patterns. Understanding these spatial differences is important for climate adaptation planning, drought and flood risk assessments, agricultural planning, environmental monitoring, and climate finance prioritization.
 
Traditional climate maps generally visualize one variable at a time, which can limit the interpretation of interactions between climatic factors. A bivariate mapping approach allows temperature and precipitation to be analyzed simultaneously, enabling users to identify areas that are:
 
- Hot and wet
- Hot and dry
- Cool and wet
- Cool and dry
- Intermediate climate zones
 
Such classifications provide a richer understanding of climate dynamics compared to single-variable maps. This exercise demonstrates how cloud-based climate datasets available through Google Earth Engine can be combined with modern cartographic techniques in R to produce both 2D and 3D climate visualizations.

The output map is shown here. https://github.com/atiqka/BGD_BV-Tmp-Pr/blob/main/BGD_Bivariate-tmp-pr.png
 
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

### Data Sources

This project integrates multiple globally recognized geospatial and climate datasets through Google Earth Engine and complementary open-source spatial data repositories. The datasets were selected based on their scientific credibility, global coverage, spatial resolution, temporal consistency, and widespread use within climate, environmental, and disaster risk research. Data sources and details are as below. 

## 1. ERA5-Land Climate Reanalysis

## Overview

ERA5-Land is a global land-surface reanalysis dataset produced by the European Centre for Medium-Range Weather Forecasts (ECMWF). It provides a physically consistent reconstruction of historical climate conditions by combining numerical weather models with observational data. ERA5-Land is specifically designed to improve land-surface representation relative to the standard ERA5 reanalysis. 【1-99390a】

## Dataset Used

```r
ECMWF/ERA5_LAND/HOURLY
```

## Variable

```r
temperature_2m
```

## Description

The variable represents near-surface air temperature measured approximately two meters above ground level.

## Temporal Coverage

```text
January 1950 – Present
```

## Temporal Resolution

```text
Hourly
```

## Spatial Resolution

```text
0.1° × 0.1°
(~9 km native resolution)
```

## Data Provider

```text
European Centre for Medium-Range Weather Forecasts (ECMWF)
Copernicus Climate Change Service (C3S)
```


---

## 2. CHIRPS Precipitation

## Overview

Climate Hazards Group InfraRed Precipitation with Stations (CHIRPS) is a long-term quasi-global rainfall dataset developed by the Climate Hazards Center at the University of California, Santa Barbara. CHIRPS combines satellite imagery with ground-based station observations to produce gridded precipitation estimates suitable for drought monitoring, climate assessment, and hydrological analysis. 【2-5559f6】

## Dataset Used

```r
UCSB-CHG/CHIRPS/DAILY
```

## Variable

```r
precipitation
```

## Description

Daily precipitation estimates derived from infrared satellite observations merged with in-situ station measurements.

## Temporal Coverage

```text
1981 – Present
```

## Temporal Resolution

```text
Daily
```

## Spatial Resolution

```text
0.05°
(~5.6 km)
```

## Data Provider

```text
Climate Hazards Group (CHG)
University of California, Santa Barbara (UCSB)
```


---

## 3. Administrative Boundaries

## Overview

National boundaries for Bangladesh were obtained using the GADM database through the R package geodata.

GADM is one of the most widely used global administrative boundary databases and provides harmonized boundary datasets for countries and subnational administrative units worldwide. The current database contains hundreds of thousands of administrative areas globally. 【3-c058fb】【4-97bdab】

## Dataset

```r
geodata::gadm("BGD", level = 0)
```

## Administrative Level

```text
ADM0 (National Boundary)
```

## Data Provider

```text
GADM Database of Global Administrative Areas
```

---

## 4. Digital Elevation Model (DEM)

## Overview

Terrain elevation data are obtained using the elevatr package, which accesses Shuttle Radar Topography Mission (SRTM) elevation products.

The SRTM mission was jointly conducted by NASA and the National Geospatial-Intelligence Agency (NGA) and produced one of the most widely used global digital elevation datasets. SRTM data provide near-global land-surface elevation coverage at approximately 30-meter resolution. 【5-933c94】【6-3d171d】

## Dataset

```text
SRTM Digital Elevation Model
```

## Resolution

```text
1 Arc-Second
(~30 meters)
```

## Coverage

```text
Global land surface between 60°N and 56°S
```

## Data Provider

```text
NASA
United States Geological Survey (USGS)
National Geospatial-Intelligence Agency (NGA)
```


---

## Data Processing Workflow

The workflow integrates the above datasets through the following sequence:

```text
ERA5-Land Temperature
          │
          ▼
      Earth Engine
          │
          ▼
  Multi-Year Mean Surface
          │
          ▼
          ├───────────────┐
          │               │
          ▼               ▼
CHIRPS Rainfall      Bangladesh Boundary
          │               │
          ▼               ▼
  Multi-Year Total     National Mask
          │               │
          └───────┬───────┘
                  ▼
        Raster Harmonization
                  ▼
      Bivariate Classification
                  ▼
          2D Climate Mapping
                  ▼
            DEM Integration
                  ▼
          3D Visualization
```

---


