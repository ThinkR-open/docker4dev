FROM thinkr/rstudio3_6_3_geo_rs1.3.959

MAINTAINER "Sébastien Rochette" sebastien@thinkr.fr

# Install packages
RUN R -e "install.packages('remotes')"

# renv
RUN R -e "remotes::install_github('rstudio/renv', upgrade = 'never')"

# All ThinkR
RUN  R -e 'options("Ncpus" = 6);source("https://raw.githubusercontent.com/ThinkR-open/installR/master/new-install.R")'

# golem and deps
RUN R -e "remotes::install_github(repo = 'ThinkR-open/golem', ref = 'dev', upgrade = 'never')"

# spatial pkg
RUN R -e "options("Ncpus" = 6);install.packages(c('here', 'Rcpp', 'units', 'sf', 'lwgeom', 'leaflet', 'raster', 'stars', 'ggspatial', 'units', 'extrafont', 'ggrepel', 'tmap', 'rnaturalearth', 'rnaturalearthdata', 'gganimate', 'terra', 'ceramic', 'rosm', 'mapview', 'mapedit', 'rgl', 'rgeos', 'magick', 'colourpicker', 'cartography', 'shinyjs', 'transformr', 'geofacet', 'mapdeck'))"
RUN R -e 'install.packages("rnaturalearthhires", repos = "http://packages.ropensci.org", type = "source")'
# RUN R -e "remotes::install_github(repo = 'r-spatial/lwgeom', ref = '1cd8e1bac5c3ae8ce56ef5368b8a87efa00e716d')"
RUN R -e "remotes::install_github('statnmap/cartomisc', upgrade = 'never')"
RUN R -e "remotes::install_github('rspatial/terra', upgrade = 'never')"
