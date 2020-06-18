FROM rocker/verse:4.0.0

MAINTAINER "Sébastien Rochette" sebastien@thinkr.fr

# RUN apt-get update && apt-get upgrade --yes

# geospatial
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    freeglut3-dev \
    lbzip2 \
    libfftw3-dev \
    libgdal-dev \
    libgeos-dev \
    libgsl0-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libhdf4-alt-dev \
    libhdf5-dev \
    libjq-dev \
    liblwgeom-dev \
    libpq-dev \
    libproj-dev \
    libprotobuf-dev \
    libnetcdf-dev \
    libsqlite3-dev \
    libssl-dev \
    libudunits2-dev \
    mesa-common-dev \
    netcdf-bin \
    postgis \
    protobuf-compiler \
    sqlite3 \
    tk-dev \
    unixodbc-dev
  
# Set MRAN (1 month after R)
RUN echo "options(repos = list(CRAN = 'https://mran.revolutionanalytics.com/snapshot/2020-05-24/'))" >> /usr/local/lib/R/etc/Rprofile.site

# Install versions available on MRAN at the correct date
RUN R -e "install.packages('remotes')"
RUN R -e 'll <- installed.packages()[,1] ; ll <- ll[-which(lapply(ll, packageDescription, field="Priority") == "base")] ; for(l in ll){try(remotes::install_version(l))}'
# RUN R -e "update.packages(ask = FALSE)"

# renv
RUN R -e "remotes::install_github('rstudio/renv', ref = '0.10.0-45')"

# golem and deps
RUN R -e "remotes::install_github(repo = 'ThinkR-open/golem', ref = 'v0.2.1')"

# spatial pkg
RUN R -e "install.packages(c('Rcpp', 'units', 'sf', 'lwgeom'))"
# RUN R -e "remotes::install_github(repo = 'r-spatial/lwgeom', ref = '1cd8e1bac5c3ae8ce56ef5368b8a87efa00e716d')"
  
