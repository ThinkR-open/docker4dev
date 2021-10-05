FROM rocker/verse:3.6.3-ubuntu18.04
# FROM rocker/verse:3.6.3

LABEL maintainer="sebastien@thinkr.fr"

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
  
RUN apt-get install -y libmagick++-dev libjq-dev libv8-dev libprotobuf-dev protobuf-compiler libsodium-dev imagemagick

# Pour {gert}
RUN apt-get install -y libgit2-dev

# database ----
RUN apt-get update && apt-get install -y --no-install-recommends \
  default-mysql-client \
  default-libmysqlclient-dev  
  
# locales ----
RUN apt-get install -y language-pack-fr

# Set Paris localtime
RUN mv /etc/localtime /etc/localtime_backup \
  && ln -s /usr/share/zoneinfo/Europe/Paris
# Other possibility : set host localtime
# COPY /etc/localtime /etc/localtime


# Install packages
RUN R -e "install.packages('remotes')"

# renv
RUN R -e "remotes::install_github('rstudio/renv', upgrade = 'never')"

# Change Rstudio MRAN 
# 296: 25 juin 2020
# RUN echo 'options(repos = c(REPO_NAME = "https://packagemanager.rstudio.com/all/__linux__/bionic/296"))' >> /usr/local/lib/R/etc/Rprofile.site
RUN echo 'options(repos = c(REPO_NAME = "https://packagemanager.rstudio.com/all/__linux__/bionic/latest/"))' >> /usr/local/lib/R/etc/Rprofile.site

# Update
RUN R -e "update.packages(ask = FALSE)"

# Webshot
RUN R -e "install.packages('webshot'); webshot::install_phantomjs()"
RUN cp ~/bin/phantomjs /usr/local/share/phantomjs \
  && chmod 0755 /usr/local/share/phantomjs \
  && ln -sf /usr/local/share/phantomjs /usr/local/bin

# Chromium for {pagedown} ----
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list
RUN apt-get install -y gnupg2 \
  && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "Comenzando actualizacion"
RUN apt-get update
RUN echo "Finalizando actualizacion"
RUN apt-get -y install libxpm4 libxrender1 libgtk2.0-0 libnss3 libgconf-2-4
RUN apt-get -y install xvfb gtk2-engines-pixbuf
RUN apt-get -y install xfonts-cyrillic xfonts-100dpi xfonts-75dpi xfonts-base xfonts-scalable
RUN apt-get -y install google-chrome-stable

  
RUN R -e "remotes::install_cran('pagedown')"

# tinytex
RUN R -e "install.packages('tinytex'); tinytex::install_tinytex()"

# renv
RUN R -e "remotes::install_github('rstudio/renv', upgrade = 'never')"

# All ThinkR
RUN  R -e 'options("Ncpus" = 6);source("https://raw.githubusercontent.com/ThinkR-open/installR/master/new-install.R")'

# golem and deps
RUN R -e "remotes::install_github(repo = 'ThinkR-open/golem', ref = 'master', upgrade = 'never')"

# spatial pkg
# RUN apt install r-cran-gstat r-cran-maps r-cran-mapdata r-cran-ncdf4 r-cran-sf r-cran-sp r-cran-raster r-cran-geor r-cran-ggmap r-cran-leaflet r-cran-rosm

RUN R -e "options('Ncpus' = 6);install.packages(c('sf', 'leaflet', 'raster', 'terra', 'rosm', 'gstat', 'maps', 'mapdata', 'ncdf4', 'sp', 'geoR', 'ggmap'))"
RUN R -e "options('Ncpus' = 6);install.packages(c('here', 'Rcpp', 'units', 'lwgeom', 'stars', 'ggspatial', 'extrafont', 'ggrepel', 'tmap', 'rnaturalearth', 'rnaturalearthdata', 'gganimate', 'terra', 'ceramic', 'mapview', 'mapedit', 'rgl', 'rgeos', 'magick', 'colourpicker', 'cartography', 'shinyjs', 'transformr', 'geofacet', 'mapdeck'))"
RUN R -e 'install.packages("rnaturalearthhires", repos = "http://packages.ropensci.org", type = "source")'
# RUN R -e "remotes::install_github(repo = 'r-spatial/lwgeom', ref = '1cd8e1bac5c3ae8ce56ef5368b8a87efa00e716d')"
RUN R -e "remotes::install_github('statnmap/cartomisc', upgrade = 'never')"
# RUN R -e "remotes::install_github('rspatial/raster', upgrade = 'never')"
# RUN R -e "remotes::install_github('rspatial/terra', upgrade = 'never')"


