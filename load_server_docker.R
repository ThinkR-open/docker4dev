firsttime <- FALSE
if (firsttime) {
  # Hide this file
  usethis::use_git_ignore("load_server_docker.R")
  usethis::use_build_ignore("load_server_docker.R")
  ## To pass the check
  usethis::use_git_ignore("library/")
  usethis::use_build_ignore("library/")
}

## Allow us to lanch the system command in a new R session
library(future)
plan(multisession)

### Set good working directory for docker volumes
if (!dir.exists(here::here("library"))) {dir.create(here::here("library"))}
my_project <- here::here()
my_library <- here::here("library")
projectname <- basename(my_project)

## Launch the server in the new R session (terminal have to be active...)
future({
  system(paste0("docker run --name ", projectname, " -v ",my_library,":/home/rstudio/library -v ",my_project,":/home/rstudio/",projectname,"  -p 127.0.0.1:8787:8787 -e DISABLE_AUTH=true rstudio3_5_2"), intern = TRUE)
})

Sys.sleep(2)
browseURL("http://127.0.0.1:8787")

stop <- FALSE
if (stop) {
  ## To stop your image after your work proprely
  system(paste("docker kill", projectname))
  system(paste("docker rm", projectname))
  
  ## If needed INSIDE the Docker Rstudio Server ----
  ### _You will need to set the credentials
  # git config credential.helper store
  # _and your name
  # usethis::use_git_config(scope = "project", user.name = "", user.email = "@thinkr.fr")
  
  ## To install new packages used
  # remotes::install_github("ThinkR-open/attachment")
  pkgs <- attachment::att_from_description()
  attachment::install_if_missing(pkgs)
}