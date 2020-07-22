FROM rocker/verse:4.0.2
# Last is ubuntu focal 20.04

MAINTAINER "Sébastien Rochette" sebastien@thinkr.fr

# RUN apt-get update && apt-get upgrade --yes

# Update Rstudio Server to 1.3.1056
RUN apt-get update \
#  && apt-get install -y --no-install-recommends \
  && RSTUDIO_URL="http://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.3.1056-amd64.deb" \
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
  