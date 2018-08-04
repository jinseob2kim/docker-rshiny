FROM ubuntu:latest

MAINTAINER Jinseob Kim "jinseob2kim@gmail.com"

# Setup apt to be happy with no console input
ENV DEBIAN_FRONTEND noninteractive


# Install dependencies and Download 
RUN apt-get update && apt-get install -y \
    udev \
    locales \
    software-properties-common \
    file \
    curl \
    git \
    sudo \
    wget \
    gdebi-core \
    vim \
    psmisc \
    tzdata \
    libxml2-dev \
    libcairo2-dev \
    libgit2-dev \
    tk-table \
    libcurl4-gnutls-dev \
    libssl-dev && \                                    # supervisor && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Prevent bugging us later about timezones
RUN ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

# Use UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8



# Update R -latest version
RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu bionic-cran35/" | sudo tee -a /etc/apt/sources.list && \
    gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9 && \
    gpg -a --export E084DAB9 | sudo apt-key add - && \
    apt-get update && \
    apt-get install -y r-base r-base-dev

# Install Rstudio-server
ARG RSTUDIO_VERSION

RUN RSTUDIO_LATEST=$(wget --no-check-certificate -qO- https://s3.amazonaws.com/rstudio-server/current.ver) && \ 
    [ -z "$RSTUDIO_VERSION" ] && RSTUDIO_VERSION=$RSTUDIO_LATEST || true && \
    wget -q http://download2.rstudio.org/rstudio-server-${RSTUDIO_VERSION}-amd64.deb && \
    dpkg -i rstudio-server-${RSTUDIO_VERSION}-amd64.deb && \
    rm rstudio-server-*-amd64.deb 


# Install Shiny server
RUN wget --no-verbose https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-14.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-14.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && \
    gdebi -n ss-latest.deb && \
    rm -f version.txt ss-latest.deb && \
    R -e "install.packages(c('shiny', 'rmarkdown', 'DT', 'data.table', 'ggplot2', 'devtools', 'epiDisplay', 'tableone', 'svglite', 'plotROC', 'pROC', 'labelled', 'geepack', 'lme4', 'PredictABEL', 'shinythemes', 'maxstat', 'manhattanly'), repos='https://cran.rstudio.com/')" && \
    R -e "devtools::install_github(c('jinseob2kim/jstable', 'jinseob2kim/jskm'))"


## configure git not to request password each time
RUN git config --system credential.helper 'cache --timeout=3600' && \ 
    git config --system push.default simple \


## Set up S6 init system
RUN wget -P /tmp/ https://github.com/just-containers/s6-overlay/releases/download/v1.11.0.1/s6-overlay-amd64.tar.gz && \ 
    tar xzf /tmp/s6-overlay-amd64.tar.gz -C / && \
    mkdir -p /etc/services.d/rstudio && \
    echo '#!/usr/bin/with-contenv bash \
          \n exec /usr/lib/rstudio-server/bin/rserver --server-daemonize 0' \
          > /etc/services.d/rstudio/run  && \
    echo '#!/bin/bash \
          \n rstudio-server stop' \
          > /etc/services.d/rstudio/finish  && \
    mkdir -p /etc/services.d/shiny-server && \
    cd /etc/services.d/shiny-server && \
    echo '#!/bin/bash' > run && echo 'exec shiny-server' >> run && \
    chmod +x run && \
    cd 
          


## initial
COPY ini.sh /etc/cont-init.d/userconf


EXPOSE 8787 3838 

CMD ["/init"]







