FROM rocker/verse:3.5.2

# RUN apt-get update && apt-get upgrade --yes

# Update Rstudio Server to 1.2.1335
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    file \
    git \
    libapparmor1 \
    libcurl4-openssl-dev \
    libedit2 \
    libssl-dev \
    lsb-release \
    psmisc \
    procps \
    python-setuptools \
    sudo \
    wget \
    libclang-dev \
    libclang-3.8-dev \
    libobjc-6-dev \
    libclang1-3.8 \
    libclang-common-3.8-dev \
    libllvm3.8 \
    libobjc4 \
    libgc1c2 \
  && RSTUDIO_URL="http://download2.rstudio.org/server/debian9/x86_64/rstudio-server-1.2.1335-amd64.deb" \
  && wget -q $RSTUDIO_URL \
  && dpkg -i rstudio-server-*-amd64.deb \
  && rm rstudio-server-*-amd64.deb
  
# Set MRAN
RUN echo "options(repos = list(CRAN = 'https://mran.revolutionanalytics.com/snapshot/2019-01-12/'))" >> /usr/local/lib/R/etc/Rprofile.site

# Install versions available on MRAN at the correct date
RUN R -e "install.packages('remotes')"
RUN R -e 'll <- installed.packages()[,1] ; ll <- ll[-which(lapply(ll, packageDescription, field="Priority") == "base")] ; lapply(ll, try(remotes::install_version))'
# RUN R -e "update.packages(ask = FALSE)"

# golem and deps
RUN R -e "remotes::install_github(repo = 'ThinkR-open/golem', ref = '51d7e98261268dab2d4972e172af473f6891107e')"

# Directory for supplemental packages
RUN R -e "dir.create('/home/rstudio/library/')"
RUN echo ".libPaths(c('/home/rstudio/library', .libPaths())); \
  ">> /home/rstudio/.Rprofile
