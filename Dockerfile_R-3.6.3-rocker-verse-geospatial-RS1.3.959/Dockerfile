FROM rocker/verse:3.6.3-ubuntu18.04
# FROM rocker/verse:3.6.3

MAINTAINER "Sébastien Rochette" sebastien@thinkr.fr

# RUN apt-get update && apt-get upgrade --yes

# Update Rstudio Server to 1.3.959
RUN apt-get update \
#  && apt-get install -y --no-install-recommends \
  && RSTUDIO_URL="http://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.3.959-amd64.deb" \
  && wget -q $RSTUDIO_URL \
  && dpkg -i rstudio-server-*-amd64.deb \
  && rm rstudio-server-*-amd64.deb

# Spatial libs
RUN apt-get update \
  && add-apt-repository --enable-source --yes "ppa:marutter/rrutter3.5" \
	&& add-apt-repository --enable-source --yes "ppa:marutter/c2d4u3.5"

# geospatial
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    lbzip2 \
    libfftw3-dev \
    libgdal-dev \
    libgeos-dev \
    libgsl0-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libhdf4-alt-dev \
    libhdf5-dev \
    libmagick++-dev \
    libjq-dev \
    liblwgeom-dev \
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
    imagemagick
  
# database
RUN apt-get install -y --no-install-recommends \
  default-mysql-client \
  default-libmysqlclient-dev  
  