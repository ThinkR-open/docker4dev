# Hide this file
usethis::use_git_ignore("install_server_docker.R")
usethis::use_build_ignore("install_server_docker.R")

## Allow us to lanch the system command in a new R session
library(future)
plan(multisession)

### Set good working directory for docker volumes
my_project <- here::here()
my_library <- here::here("library")

# First creation of the package
firsttime <- FALSE
if (firsttime) {
  ## To pass the check
  usethis::use_git_ignore("library/")
  usethis::use_build_ignore("library/")
  usethis::use_build_ignore("install_server.R")
  usethis::use_build_ignore("script_for_package.R")
  usethis::use_build_ignore("Dockerfile")
  
  ## Build the image with the Dockerfile if necessary
  system("docker build -t rstudio3_5_2 .", intern = TRUE)
  # Send to Docker hub
  # docker login --username=yourhubusername
  # docker images 
  # Find the latest build
  # docker tag 27cebcec37e1 yourhubusername/rstudio3_5_2:v0.2
  # docker push yourhubusername/rstudio3_5_2:v0.2
  # Or use docker pull thinkr/rstudio3_5_2
}

## Launch the server in the new R session (terminal have to be active...)
future({
  system(paste0("docker run --name serveraegen -v ",my_library,":/home/rstudio/library -v ",my_project,":/home/rstudio/aegen  -p 127.0.0.1:8787:8787 -e DISABLE_AUTH=true   rstudio3_5_2"), intern = TRUE)
})

# _You will need to set the credentials
# git config credential.helper store
# _and your name
# usethis::use_git_config(scope = "project", user.name = "", user.email = "@thinkr.fr")

Sys.sleep(2)
browseURL("http://127.0.0.1:8787")

## To stop your image after your work proprely
system("docker kill serveraegen")
system("docker rm serveraegen")

