# Creation of the Docker container
## Build the image with the Dockerfile if necessary
system("docker build -t rstudio3_5_2 Dockerfile_R-3.5.2-rocker-verse", intern = FALSE)
system("docker build -t rstudio3_5_2_geo Dockerfile_R-3.5.2-rocker-verse-geospatial", intern = FALSE)

## Send to Docker hub
# docker login --username=thinkr
# docker images 
## _Find the latest build of your image
# docker tag 518a41981a6a myRegistry.com/myImage
# ou
# docker tag rstudio3_5_2_geo thinkr/rstudio3_5_2_geo:latest
## _Push
# docker push thinkr/rstudio3_5_2_geo:latest
## Get
# Or use docker pull thinkr/rstudio3_5_2
# docker pull thinkr/rstudio3_5_2_geo

