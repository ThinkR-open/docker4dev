# First time ----
firsttime <- FALSE
if (firsttime) {
  # Hide this file
  usethis::use_git_ignore("load_server_docker.R")
  usethis::use_build_ignore("load_server_docker.R")
  ## To pass the check
  usethis::use_git_ignore("library/")
  usethis::use_build_ignore("library/")
  # last-project-path
  # usethis::use_build_ignore("last-project-path")
  # usethis::use_git_ignore("last-project-path")
  # rstudio preferences
  dir.create("rstudio_prefs")
  usethis::use_build_ignore("rstudio_prefs")
  usethis::use_git_ignore("rstudio_prefs")
}

# Do we use databases ----
with_databases <- FALSE

# Which Rstudio container ? ----
container <- c("thinkr/rstudio3_5_2",
               "thinkr/rstudio3_5_2_geo",
               "thinkr/rstudio3_6_1_geo")[2]

if (with_databases) {
  container <- "colinfay/r-db:3.6.1"
}

# Pull container if needed
if (FALSE) {
  system(paste("docker pull", container))
  system("docker pull mysql:8.0.16")
}

# Which port ? ----
# _Useful if multiple Rstudio Server to launch
port <- 8787

# Future ----
## Allow us to lanch the system command in a new R session
library(future)
# Requires at least 2 workers otherwise does not work
plan(multisession(workers = 2))


# Databases container ----
if (with_databases) {
  # system("docker pull colinfay/r-db:3.6.1")
  # system("docker pull mysql:8.0.16")
  
  system("docker network create r-db")
  
  future({
    system(
      paste0(
        'docker run --net r-db',
        ' --name mysql -e MYSQL_ROOT_PASSWORD=coucou -d mysql:8.0.16',
        ' --default-authentication-plugin=mysql_native_password',
        ' && sleep 30',
        ' && docker exec mysql mysql -uroot -pcoucou -e "create database mydb"')
    )
  })
  
}


## Launch ----

### Set good working directory for docker volumes
if (!dir.exists(here::here("library"))) {dir.create(here::here("library"))}
my_project <- here::here()
my_library <- here::here("library")
projectname <- basename(my_project)

# Force rstudio to use the current project as the last path to be directly opened
if (!file.exists(paste0(projectname, ".Rproj"))) {
  stop(".Rproj file should have the same name as the working directory and project name")
}

# cat("/home/rstudio/", projectname, "/", projectname, ".Rproj",
#     sep = "", file = "last-project-path")

## Launch the server in the new R session (terminal have to be active...)
future({
  system(
    paste0(
      "docker run --name ", projectname,
      ifelse(isTRUE(with_databases), " --net r-db", ""),
      # " -it",
      " -d -e DISABLE_AUTH=true",
      " -v ", my_library, ":/home/rstudio/library",
      " -v ", my_project, ":/home/rstudio/", projectname,
      # " -v ", my_project, "/last-project-path", ":/home/rstudio/.rstudio/projects_settings/last-project-path",
      " -v ", my_project, "/rstudio_prefs", ":/home/rstudio/.rstudio",
      # " -p ", port, ":8787 -e DISABLE_AUTH=true ",
      " -p 127.0.0.1:", port, ":8787 ",
      container),
    intern = TRUE)
})

Sys.sleep(2)
browseURL(paste0("http://127.0.0.1:", port))

stop <- FALSE
if (stop) {
  # --- /!\ Do not forget to stop properly the Rstudio Server /!\ --- #
  # Click on Top right button to quit or `q()` in the console
  
  ## To stop your image after your work proprely
  if (isTRUE(with_databases)) {
    system("docker kill mysql")
    system("docker rm mysql")
  }
  system(paste("docker kill", projectname))
  system(paste("docker rm", projectname))
  
  if (isTRUE(with_databases)) {
    system("docker network remove r-db")
  }
  ## If needed INSIDE the Docker Rstudio Server ----
  ### _You will need to set the credentials
  # git config credential.helper store
  # _and your name
  # usethis::use_git_config(scope = "project", user.name = "", user.email = "@thinkr.fr")
  ## Template git
  # git2r::config(global = FALSE, commit.template = "config_git/template_commit")
  
  ## To install new packages used
  # remotes::install_github("ThinkR-open/attachment")
  pkgs <- attachment::att_from_description()
  attachment::install_if_missing(pkgs)
  
  # If you installed package from github or forced one CRAN
  # you may have to be sure to install dependencies from MRAN
  ll <- list.files("library")
  for (l in ll) {
    try(remotes::install_version(l))
  }
}
