FROM rocker/verse:4.0.2
# Last is ubuntu focal 20.04

MAINTAINER "Sébastien Rochette" sebastien@thinkr.fr

# RUN apt-get update && apt-get upgrade --yes

# Update Rstudio Server to 1.3.959
RUN apt-get update \
#  && apt-get install -y --no-install-recommends \
#  && RSTUDIO_URL="http://download2.rstudio.org/server/focal/amd64/rstudio-server-1.3.959-amd64.deb" \
  && RSTUDIO_URL="https://s3.amazonaws.com/rstudio-ide-build/server/bionic/amd64/rstudio-server-1.3.959-amd64.deb" \
  && wget -q $RSTUDIO_URL \
  && dpkg -i rstudio-server-*-amd64.deb \
  && rm rstudio-server-*-amd64.deb

# Spatial libs
RUN apt-get update \
  && apt-get install -y --no-install-recommends software-properties-common \
	&& add-apt-repository --enable-source --yes "ppa:c2d4u.team/c2d4u4.0+"

# geospatial
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    lbzip2 \
    libfftw3-dev \
    libcairo2-dev \
    libgdal-dev \
    libgeos-dev \
    libgsl0-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libhdf4-alt-dev \
    libhdf5-dev \
    libmagick++-dev \
    libjq-dev \
#    liblwgeom-dev \
    libnode-dev \
    libpq-dev \
    libproj-dev \
    libprotobuf-dev \
    libnetcdf-dev \
    libsqlite3-dev \
    libssl-dev \
    libudunits2-dev \
    netcdf-bin \
    postgis \
    protobuf-compiler \
    sqlite3 \
    tk-dev \
    unixodbc-dev \
    imagemagick \
    freeglut3-dev \
    mesa-common-dev
  
# database
RUN apt-get install -y --no-install-recommends \
  default-mysql-client \
  default-libmysqlclient-dev  
  
# locales
RUN apt-get install -y language-pack-fr

# Install packages
RUN R -e "install.packages('remotes')"

# renv
RUN R -e "remotes::install_github('rstudio/renv', upgrade = 'never')"

# Change Rstudio MRAN 
# 296: 25 juin 2020
# 316: 31 aout 2020
RUN echo 'options(repos = c(REPO_NAME = "https://packagemanager.rstudio.com/cran/__linux__/focal/316"))' >> /usr/local/lib/R/etc/Rprofile.site

# Update
RUN R -e "update.packages(ask = FALSE)"

# All ThinkR
RUN  R -e 'options("Ncpus" = 6);source("https://raw.githubusercontent.com/ThinkR-open/installR/master/new-install.R")'

# golem and deps
RUN R -e "remotes::install_github(repo = 'ThinkR-open/golem', ref = 'master', upgrade = 'never')"

# spatial pkg
# RUN apt-get install r-cran-gstat r-cran-maps r-cran-mapdata r-cran-ncdf4 r-cran-sf r-cran-sp r-cran-raster r-cran-geor r-cran-ggmap r-cran-leaflet r-cran-rosm

RUN R -e "options("Ncpus" = 6);install.packages(c('sf', 'leaflet', 'raster', 'rosm', 'gstat', 'maps', 'mapdata', 'ncdf4', 'sp', 'geoR', 'ggmap'))"

RUN R -e "options("Ncpus" = 6);install.packages(c('here', 'Rcpp', 'units', 'lwgeom', 'stars', 'ggspatial', 'extrafont', 'ggrepel', 'tmap', 'rnaturalearth', 'rnaturalearthdata', 'gganimate', 'terra', 'ceramic', 'mapview', 'mapedit', 'rgl', 'rgeos', 'magick', 'colourpicker', 'cartography', 'shinyjs', 'transformr', 'geofacet', 'mapdeck'))"
RUN R -e 'install.packages("rnaturalearthhires", repos = "http://packages.ropensci.org", type = "source")'
RUN R -e "remotes::install_github('statnmap/cartomisc', upgrade = 'never')"

