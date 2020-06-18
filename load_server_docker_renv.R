# project_path <- "" # default
project_path <- "/mnt/Data/ThinkR/Gitlab/Missions/test.renv/"

# Do we use databases ----
with_mysql <- FALSE

# Which Rstudio container ? ----
container <- c("thinkr/rstudio3_5_2",
               "thinkr/rstudio3_5_2_geo",
               "thinkr/rstudio3_6_1_geo")[3]

if (with_mysql) {
  container <- "colinfay/r-db:3.6.1"
}

# Which port ? ----
# _Useful if multiple Rstudio Server to launch
port <- 8785

#' Launch Docker
#' 
#' @param project_path Path to project to launch.
#' @param container Docker container to download from docker hub.
#' @param with_mysql Logical. Use MySQL database or not.
#' @param mysql_docker Mysql docker container to download from docker hub.
#' @param port Local port to which to launch Rstudio Server
#' @param renv_inst Logical. Whether to add a R script with {renv} instructions in the project.

launch_proj_docker <- function(project_path = "",
                               container = "thinkr/rstudio3_6_1_geo",
                               with_mysql = FALSE,
                               mysql_docker = "mysql:8.0.16",
                               port = 8787,
                               renv_inst = TRUE) {
  # First time ----
  if (!dir.exists("rstudio_prefs")) {
    # Hide this file
    # usethis::use_git_ignore("load_server_docker.R")
    # usethis::use_build_ignore("load_server_docker.R")
    ## To pass the check
    # usethis::use_git_ignore("library/")
    # usethis::use_build_ignore("library/")
    usethis::use_git_ignore("renv/")
    # last-project-path
    # usethis::use_build_ignore("last-project-path")
    # usethis::use_git_ignore("last-project-path")
    # rstudio preferences
    dir.create("rstudio_prefs")
    usethis::use_build_ignore("rstudio_prefs")
    usethis::use_git_ignore("rstudio_prefs")
  }
  
  # Pull container if needed
  # if (FALSE) {
  #   system(paste("docker pull", container))
  #   system("docker pull mysql:8.0.16")
  # }
  
  # Future ----
  ## Allow us to lanch the system command in a new R session
  # library(future)
  # Requires at least 2 workers otherwise does not work
  future::plan(future::multisession(workers = 2))
  
  
  # Databases container ----
  if (with_mysql) {
    # system("docker pull colinfay/r-db:3.6.1")
    # system("docker pull mysql:8.0.16")
    
    system("docker network create r-db")
    
    future::future({
      system(
        paste0(
          'docker run --net r-db',
          ' --name mysql -e MYSQL_ROOT_PASSWORD=coucou -d ', mysql_docker,
          ' --default-authentication-plugin=mysql_native_password',
          ' && sleep 30',
          ' && docker exec mysql mysql -uroot -pcoucou -e "create database mydb"')
      )
    })
  }
  
  
  ## Launch ----
  
  ### Set good working directory for docker volumes
  # if (!dir.exists(file.path(project_path, "library"))) {dir.create(file.path(project_path, "library"))}
  my_project <- project_path #here::here()
  # my_library <- here::here("library")
  projectname <- basename(my_project)
  
  # {renv} path in container
  # RENV_PATHS_CACHE_CONTAINER <- "/mnt/shared/renv/cache"
  # Directory with all {renv} package cache
  # RENV_PATHS_CACHE_HOST <- "/mnt/Data/renv"
  # if (!dir.exists(RENV_PATHS_CACHE_HOST)) {dir.create(RENV_PATHS_CACHE_HOST)}
  # /!\ Do not do that because only one version of each package is possible for each R version
  # Sys.setenv(RENV_PATHS_CACHE = "/mnt/shared/renv/cache");
  
  
  ## Launch the server in the new R session (terminal have to be active...)
  future({
    system(
      paste0(
        "docker run --name ", projectname,
        ifelse(isTRUE(with_mysql), " --net r-db", ""),
        # " -it",
        " -d -e DISABLE_AUTH=true",
        # {renv}    
        # " -e RENV_PATHS_CACHE=", RENV_PATHS_CACHE_CONTAINER,
        # " -v ", RENV_PATHS_CACHE_HOST, ":", RENV_PATHS_CACHE_CONTAINER,
        
        # " -v ", my_library, ":/home/rstudio/library",
        " -v ", my_project, ":/home/rstudio/", projectname,
        # " -v ", my_project, "/last-project-path", ":/home/rstudio/.rstudio/projects_settings/last-project-path",
        " -v ", my_project, "/rstudio_prefs", ":/home/rstudio/.rstudio",
        # " -p ", port, ":8787 -e DISABLE_AUTH=true ",
        " -p 127.0.0.1:", port, ":8787 ",
        container),
      intern = TRUE)
  })
  
  if (isTRUE(renv_inst)) {
    if (!file.exists(file.path(my_project, "renv_instructions.R"))) {
      
      cat("# Hide this file from your project\n",
          "usethis::use_git_ignore('renv_instructions.R')\n",
          "usethis::use_build_ignore('renv_instructions.R')\n\n",
          
          "# The first time you launch your project in the Docker container, run :\n",
          " renv::consent(TRUE)\n",
          " renv::activate()\n\n",
          
          "# After you updated packages, added new ones or removed somes,\n", 
          "# and if you are satisfied with the effects, run: \n",
          " renv::snapshot()\n\n",
          
          "# If you are not satisfied, run:\n",
          " renv::restore() # instead of snapshot()\n\n",
          
          "# If you are ready to send your modifications to the git server, \n",
          "# And after you ran `devtools::check()`, store your packages list with: \n",
          " renv::snapshot()\n\n",
          
          "# If you updated your branch from the server, \n",
          "# there may be new packages needed, therefore run: \n",
          " renv::restore() \n\n\n",
          
          "# If you installed package from github or forced one CRAN \n",
          "# you may have to be sure to install dependencies from MRAN\n",
          "ll <- list.files('library')\n",
          "for (l in ll) {\n",
          "   try(remotes::install_version(l))\n",
          " }\n\n",
          
          file = file.path(my_project, "renv_instructions.R"))
    }
  }
  Sys.sleep(2)
  browseURL(paste0("http://127.0.0.1:", port))
}

#' Stop running Docker container
#' 
#' @param project_path Path to project to stop
#' @param with_mysql Logical. If you used MySQL database or not.
#' 
stop_proj_docker <- function(project_path, with_mysql = FALSE) {
  
  projectname <- basename(my_project)
  
  message("
  # --- /!\ Do not forget to stop properly the Rstudio Server /!\ --- #
  # Click on Top right button to quit or `q()` in the console
  ")
  
  Sys.sleep(10)
  
  ## To stop your image after your work proprely
  if (isTRUE(with_mysql)) {
    system("docker kill mysql")
    system("docker rm mysql")
  }
  system(paste("docker kill", projectname))
  system(paste("docker rm", projectname))
  
  if (isTRUE(with_mysql)) {
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
  # pkgs <- attachment::att_from_description()
  # attachment::install_if_missing(pkgs)
  # renv::restore()
  
  # If you installed package from github or forced one CRAN
  # you may have to be sure to install dependencies from MRAN
  # ll <- list.files("library")
  # for (l in ll) {
  #   try(remotes::install_version(l))
  # }
}
