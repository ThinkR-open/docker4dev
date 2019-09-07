#' Install from our git
#'
#' @param ... Other options for \code{\link{install_git}}
#'
#' @inheritParams remotes::install_gitlab
#' @inheritParams remotes::install_git
#' @inheritParams git2r::cred_user_pass
#'
#' @importFrom utils install.packages
#' 
#' @export
#' 
#' @examples
#' username <- rstudioapi::showPrompt("username", "Please enter your git username:", "name")
#' password <- rstudioapi::askForPassword()
#' install_git_with_pwd(repo = "Vincent/cloudy",
#'                      username = username,
#'                      password = password)
#' 

install_git_with_pwd <- function(repo = "ThinkR/Missions/pkgname",
                                 username, password,
                                 host = "git.thinkr.fr", dependencies = TRUE,
                                 build_opts = c("--no-resave-data", "--no-manual",
                                                "--no-build-vignettes"),
                                 ...)  {
  
  if (!requireNamespace("devtools")) { install.packages("devtools")}
  if (!requireNamespace("git2r")) { install.packages("git2r")}
  
  credentials <- git2r::cred_user_pass(username, password)
  
  devtools::install_git(
    url = paste0("https://", host,"/", repo,".git"),
    build_opts = build_opts,
    credentials = credentials,
    dependencies = dependencies,
    ...)
  
}

