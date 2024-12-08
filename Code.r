# Load Required Packages
# Specify a list of required R packages
required_packages <- c("sf", "R.utils", "scales", "deckgl", "htmlwidgets", "leaflet")

# Check if required packages are installed
installed <- required_packages %in% rownames(installed.packages())

# Install any missing packages
if (any(!installed)) {
  install.packages(required_packages[!installed])
}

# Load libraries dynamically
invisible(lapply(required_packages, library, character.only = TRUE))

# Set Kontur Population Data URL for Japan
options(timeout = 300)  # Increase timeout to handle large downloads
url <- "https://geodata-eu-central-1-kontur-public.s3.amazonaws.com/kontur_datasets/kontur_population_JP_20231101.gpkg.gz"

# Extract filename from URL
filename <- basename(url)

# Download and unzip the population data
download.file(url = url, destfile = filename, mode = "wb")  # Download the file in binary mode
R.utils::gunzip(filename, remove = FALSE)  # Unzip the downloaded file but keep the original

# Load the population data using the `sf` package
pop_data <- sf::st_read(dsn = sub(".gz$", "", filename)) %>%  # Read the unzipped GeoPackage file
  sf::st_transform(crs = "EPSG:4326")  # Transform the coordinate system to WGS 84 (EPSG:4326)

# Define a color palette based on population data
palette <- scales::col_quantile(
  palette = "viridis",        # Use the 'viridis' color palette for visualization
  domain = pop_data$population,  # Apply the palette to the population column
  n = 6                       # Divide population data into 6 quantile-based bins
)

# Assign colors to the population data
pop_data$color <- palette(pop_data$population)  # Map each population value to a color

# Define properties for the interactive 3D map
properties <- list(
  stroked = TRUE,               # Draw borders around polygons
  filled = TRUE,                # Fill polygons with color
  extruded = TRUE,              # Enable 3D extrusion of polygons based on population
  wireframe = FALSE,            # Disable wireframe lines
  elevationScale = 1,           # Scale the 3D extrusion
  getFillColor = ~color,        # Set fill color based on the assigned color column
  getLineColor = ~color,        # Set line color based on the assigned color column
  getElevation = ~population,   # Set polygon height based on population
  getPolygon = deckgl::JS("d => d.geom.coordinates"),  # Specify the geometry of the polygons
  tooltip = "Population: {{population}}",  # Define the tooltip text format
  opacity = 0.25                # Set transparency for the polygons
)

# Create an interactive 3D map centered on Japan
map <- deckgl::deckgl(
  latitude = 36.2048,          # Center the map at the latitude of Japan
  longitude = 138.2529,        # Center the map at the longitude of Japan
  zoom = 5,                    # Set initial zoom level
  pitch = 45                   # Tilt the map for a 3D perspective
) %>%
  # Add a polygon layer with population data and defined properties
  deckgl::add_polygon_layer(data = pop_data, properties = properties) %>%
  # Add a basemap using Carto's default style for better context
  deckgl::add_basemap(deckgl::use_carto_style())

# Export the interactive map as an HTML file
htmlwidgets::saveWidget(
  widget = map,               # The map widget to save
  file = "3D-Population-Map-Of-Japan.html",  # Output file name
  selfcontained = FALSE       # Save external dependencies in separate files
)

# Print completion message
print("Interactive 3D map of Japan's population created successfully!")
