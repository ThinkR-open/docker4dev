FROM rocker/geospatial:4.0.2
# Last is ubuntu focal 20.04

LABEL maintainer="sebastien@thinkr.fr"

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

# Docker ----
# Not necessary

# Change Rstudio MRAN to latest and binary
RUN echo 'options(repos = c(REPO_NAME = "https://packagemanager.rstudio.com/all/__linux__/focal/latest"))' >> /usr/local/lib/R/etc/Rprofile.site

# Install packages ----
RUN R -e "install.packages('remotes')"

# Webshot
RUN R -e "install.packages('webshot'); webshot::install_phantomjs()"
RUN cp ~/bin/phantomjs /usr/local/share/phantomjs \
  && chmod 0755 /usr/local/share/phantomjs \
  && ln -sf /usr/local/share/phantomjs /usr/local/bin

# tinytex
RUN R -e "install.packages('tinytex'); tinytex::install_tinytex()"

# renv
RUN R -e "remotes::install_github('rstudio/renv', upgrade = 'never')"

# Update
RUN R -e "update.packages(ask = FALSE)"

# All ThinkR
RUN  R -e 'options("Ncpus" = 6);source("https://raw.githubusercontent.com/ThinkR-open/installR/master/new-install.R")'

# golem, fusen and deps
RUN R -e "remotes::install_github(repo = 'ThinkR-open/golem', ref = 'master', upgrade = 'never')"
RUN R -e "remotes::install_github(repo = 'ThinkR-open/fusen', ref = 'master', upgrade = 'never')"

# spatial pkg
# RUN apt-get install r-cran-gstat r-cran-maps r-cran-mapdata r-cran-ncdf4 r-cran-sf r-cran-sp r-cran-raster r-cran-geor r-cran-ggmap r-cran-leaflet r-cran-rosm

RUN R -e "options('Ncpus' = 6);install.packages(c('sf', 'leaflet', 'raster', 'rosm', 'gstat', 'maps', 'mapdata', 'ncdf4', 'sp', 'geoR', 'ggmap'))"

RUN R -e "options('Ncpus' = 6);install.packages(c('here', 'Rcpp', 'units', 'lwgeom', 'stars', 'ggspatial', 'extrafont', 'ggrepel', 'tmap', 'rnaturalearth', 'rnaturalearthdata', 'gganimate', 'terra', 'ceramic', 'mapview', 'mapedit', 'rgl', 'rgeos', 'magick', 'colourpicker', 'cartography', 'shinyjs', 'transformr', 'geofacet', 'mapdeck', 'rasterVis'))"
RUN R -e 'install.packages("rnaturalearthhires", repos = "http://packages.ropensci.org", type = "source")'
RUN R -e "remotes::install_github('statnmap/cartomisc', upgrade = 'never')"

# Chromium for {pagedown} ----
# RUN apt-get install -y chromium-browser 

# RUN apt-get install -y software-properties-common \
#  && add-apt-repository ppa:canonical-chromium-builds/stage \
#  && apt-get install -y chromium-browser 

# RUN apt-get install -y snapd && snap install chromium

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
  
