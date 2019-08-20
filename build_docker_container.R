# Creation of the Docker container
## Build the image with the Dockerfile if necessary
system("docker build -t rstudio3_5_2 .", intern = TRUE)

# Send to Docker hub
# docker login --username=yourhubusername
# docker images 
# Find the latest build
# docker tag 27cebcec37e1 yourhubusername/rstudio3_5_2:v0.2
# docker push yourhubusername/rstudio3_5_2:v0.2
# Or use docker pull thinkr/rstudio3_5_2
