FROM thinkr/rstudio3_6_3_geo_rs1.3.959_pkg

MAINTAINER "Sébastien Rochette" sebastien@thinkr.fr

# Set MRAN 1 month after R3.6.3
# RUN echo "options(repos = list(CRAN = 'https://mran.revolutionanalytics.com/snapshot/2020-03-29/'))" >> /usr/local/lib/R/etc/Rprofile.site

# Change Rstudio MRAN 
# 296: 25 juin 2020
RUN echo "options(repos = c(REPO_NAME = "https://packagemanager.rstudio.com/all/__linux__/bionic/296"))" >> /usr/local/lib/R/etc/Rprofile.site

# Install versions available on MRAN at the correct date
RUN R -e "install.packages('remotes')"
RUN R -e 'll <- installed.packages()[,1] ; ll <- ll[-which(lapply(ll, packageDescription, field="Priority") == "base")] ; for(l in ll){try(remotes::install_version(l))}'
# RUN R -e "update.packages(ask = FALSE)"
