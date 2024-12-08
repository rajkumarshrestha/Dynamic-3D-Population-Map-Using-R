# Dynamic 3D Population Map Using R

## **Objective**  
The goal of this project is to create an interactive, visually engaging, and informative map that allows users to explore population density data dynamically. 

## **Overview**  
This project visualizes population density across Japan using an interactive 3D map built with R. The visualization highlights population distribution with color-coded polygons and elevation-based representation, making it easy to discern patterns and differences. The use of the `deckgl` package provides interactivity, enabling users to explore data dynamically. Custom color palettes further enhance the visual differentiation, making the map a powerful tool for geographic and demographic analysis.

## **Prerequisites**  
To fully utilize this project, the following prerequisites are recommended:  
- **Basic Knowledge of R**: Familiarity with R programming and geospatial libraries like `sf`.  
- **GIS Data Handling**: Understanding geospatial data formats such as shapefiles or GeoPackages.  
- **3D Data Visualization**: Experience with 3D plotting and map interactivity using tools like `deckgl`.

## **Libraries and Tools**  
The following R libraries are required to run this project:  
- **sf**: For reading and handling geospatial data.  
- **R.utils**: For managing compressed files.  
- **scales**: For generating color scales.  
- **deckgl**: For creating interactive 3D visualizations.  
- **htmlwidgets**: For saving the interactive map as an HTML file.  
- **RColorBrewer** *(Optional)*: For additional color palette options.  
- **leaflet**: For handling color binning and palette creation.  

## **Project Workflow**  

### **1. Set Up Required Packages**  
The script ensures that all necessary libraries are installed and loaded. Missing packages are installed automatically.  

### **2. Download and Extract Population Data**  
The project uses high-resolution population density data from the Kontur dataset. This data, compressed in `.gpkg.gz` format, is downloaded and extracted for analysis.  

### **3. Load and Transform Population Data**  
The population data is read using the `sf` package and transformed into the WGS84 coordinate reference system (CRS) with EPSG:4326. This transformation is essential for accurate mapping and visualization.  

### **4. Define a Custom Color Palette**  
A custom color palette, ranging from cyan to red, is created to represent varying levels of population density. The data is classified into six bins to improve visual clarity and interpretation.  

### **5. Create an Interactive 3D Map**  
Using the `deckgl` package, the project creates an interactive 3D map. Each polygon on the map is extruded based on population density, with colors reflecting density levels. This visualization is both dynamic and intuitive, providing an engaging way to explore geographic and demographic data.  

### **6. Save the Map as an HTML File**  
The interactive map is exported as an HTML file using the `htmlwidgets` package. This makes it easy to share and view the map in a web browser.  

## **Conclusion**  
This project showcases how R can be used to create interactive 3D maps that transform geospatial data into actionable insights. By integrating powerful libraries like `deckgl` and `sf`, the project delivers a customizable, user-friendly visualization of Japan's population distribution. The final map is not only an analytical tool but also a visually compelling representation of demographic patterns.  

## **Population Data Source**  
The population data for this project is sourced from the **Kontur population dataset**. You can download the dataset from the following link:  
[Kontur Population Dataset - Japan](https://data.humdata.org/dataset/kontur-population-japan)  

