# Creation of the Docker container
## Build the image with the Dockerfile if necessary
system("docker build -t rstudio3_5_2 Dockerfile_R-3.5.2-rocker-verse", intern = FALSE)
system("docker build -t rstudio3_5_2_geo Dockerfile_R-3.5.2-rocker-verse-geospatial", intern = FALSE)
system("docker build -t rstudio4_0_0_geo_renv Dockerfile_R-4.0.0-rocker-verse-geospatial-renv", intern = FALSE)
system("docker build -t docker4dev geospatial_thinkr", intern = FALSE)


# R4.0 ====================================
# Add packages with MRAN
id <- rstudioapi::terminalExecute("docker build -t docker4dev geospatial_thinkr")
rstudioapi::terminalKill(id = id)
system("docker tag docker4dev thinkr/geospatial_thinkr:latest")

# R4.0 RStudio 1.4 with Docker simpler image
id <- rstudioapi::terminalExecute("docker build -t geospatial_thinkr Dockerfile_R-4.0.2-geospatial-thinkr")
rstudioapi::terminalKill(id = id)
system("docker tag docker4dev thinkr/geospatial_thinkr:latest")

