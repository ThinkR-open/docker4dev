# Creation of the Docker container
## Build the image with the Dockerfile if necessary
system("docker build -t rstudio3_5_2 Dockerfile_R-3.5.2-rocker-verse", intern = FALSE)
system("docker build -t rstudio3_5_2_geo Dockerfile_R-3.5.2-rocker-verse-geospatial", intern = FALSE)
system("docker build -t rstudio3_6_1_geo Dockerfile_R-3.6.1-rocker-verse-geospatial", intern = FALSE)
system("docker build -t rstudio3_6_1_geo_renv Dockerfile_R-3.6.1-rocker-verse-geospatial-renv", intern = FALSE)
system("docker build -t rstudio3_6_3_geo_renv Dockerfile_R-3.6.3-rocker-verse-geospatial-renv", intern = FALSE)
system("docker build -t rstudio4_0_0_geo_renv Dockerfile_R-4.0.0-rocker-verse-geospatial-renv", intern = FALSE)

# R4.0.0 not ready for spatial. Missing liblwgeom

# R 3.6 ===============================
# RStudio update et systemfile carto
id <- rstudioapi::terminalExecute("docker build -t rstudio3_6_3_geo_rs1.3.959 Dockerfile_R-3.6.3-rocker-verse-geospatial-RS1.3.959")
rstudioapi::terminalKill(id = id)
system("docker tag rstudio3_6_3_geo_rs1.3.959 thinkr/rstudio3_6_3_geo_rs1.3.959:latest")

# Add packages
id <- rstudioapi::terminalExecute("docker build -t rstudio3_6_3_geo_rs1.3.959_pkg Dockerfile_R-3.6.3-rocker-verse-geospatial-RS1.3.959-pkg")
rstudioapi::terminalKill(id = id)
system("docker tag rstudio3_6_3_geo_rs1.3.959_pkg thinkr/rstudio3_6_3_geo_rs1.3.959_pkg:latest")

# Set MRAN and reinstall package with MRAN
id <- rstudioapi::terminalExecute("docker build -t rstudio3_6_3_geo_rs1.3.959_pkg_mran Dockerfile_R-3.6.3-rocker-verse-geospatial-RS1.3.959-pkg-mran")
rstudioapi::terminalKill(id = id)
system("docker tag rstudio3_6_3_geo_rs1.3.959_pkg_mran thinkr/rstudio3_6_3_geo_rs1.3.959_pkg_mran:latest")

# R4.0 ====================================
# RStudio update et systemfile carto
id <- rstudioapi::terminalExecute("docker build -t rstudio4_0_2_geo_rs1.3.1056 Dockerfile_R-4.0.2-rocker-verse-geospatial-RS1.3.1056")
rstudioapi::terminalKill(id = id)
system("docker tag rstudio4_0_2_geo_rs1.3.1056 thinkr/rstudio4_0_2_geo_rs1.3.1056:latest")

# Add packages with MRAN
id <- rstudioapi::terminalExecute("docker build -t rstudio4_0_2_geo_rs1.3.1056_pkg Dockerfile_R-4.0.2-rocker-verse-geospatial-RS1.3.1056-pkg")
rstudioapi::terminalKill(id = id)
system("docker tag rstudio4_0_2_geo_rs1.3.1056_pkg thinkr/rstudio4_0_2_geo_rs1.3.1056_pkg:latest")


## Send to Docker hub
# docker login --username=<my_username>
# docker images 
## _Find the latest build of your image
# docker tag 518a41981a6a myRegistry.com/myImage
# ou
# docker tag rstudio3_5_2 thinkr/rstudio3_5_2:latest
# docker tag rstudio3_6_1_geo thinkr/rstudio3_6_1_geo:latest
# docker tag rstudio3_6_1_geo_renv thinkr/rstudio3_6_1_geo_renv:latest
## _Push
# docker push thinkr/rstudio3_5_2:latest
# docker push thinkr/rstudio3_6_1_geo:latest
# docker push thinkr/rstudio3_6_1_geo_renv:latest

# docker push thinkr/rstudio3_6_3_geo_rs1.3.959
# docker push thinkr/rstudio3_6_3_geo_rs1.3.959_pkg
## Get
# Or use docker pull thinkr/rstudio3_5_2
# docker pull thinkr/rstudio3_5_2_geo

