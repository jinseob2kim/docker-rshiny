FROM ubuntu:19.10

#RUN sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list && \
#    sed -i 's/security.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list  && \
#    sed -i 's/extras.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list

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
    libclang-dev \
    tk-table \
    libcurl4-gnutls-dev \
    libssl-dev \
    libxt-dev \
    qpdf \
    supervisor && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Prevent bugging us later about timezones
RUN ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

# Use UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8


# Update R -latest version
RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu disco-cran35/" | sudo tee -a /etc/apt/sources.list && \
    gpg --keyserver keyserver.ubuntu.com --recv-key 51716619E084DAB9 && \
    gpg -a --export 51716619E084DAB9 | sudo apt-key add - && \
    apt-get update && \
    apt-get install -y r-base r-base-dev


# Install Rstudio-server

#ARG RSTUDIO_VERSION
#
#RUN RSTUDIO_LATEST=$(wget --no-check-certificate -qO- https://s3.amazonaws.com/rstudio-server/current.ver) && \ 
#    [ -z "$RSTUDIO_VERSION" ] && RSTUDIO_VERSION=$RSTUDIO_LATEST || true && \
#    wget -q http://download2.rstudio.org/rstudio-server-${RSTUDIO_VERSION}-amd64.deb && \
#    dpkg -i rstudio-server-${RSTUDIO_VERSION}-amd64.deb && \
#    rm rstudio-server-*-amd64.deb 

RUN wget -q https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.2.5019-amd64.deb && \
    dpkg -i rstudio-server-1.2.5019-amd64.deb && \
    rm rstudio-server-*-amd64.deb 
    

# Install Shiny server
RUN wget --no-verbose https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-14.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-14.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && \
    gdebi -n ss-latest.deb && \
    rm -f version.txt ss-latest.deb && \
    R -e "install.packages(c('shiny', 'rmarkdown', 'DT', 'data.table', 'ggplot2', 'devtools', 'epiDisplay', 'tableone', 'svglite', 'plotROC', 'pROC', 'labelled', 'geepack', 'lme4', 'PredictABEL', 'shinythemes', 'maxstat', 'manhattanly', 'Cairo', 'future', 'promises', 'GGally', 'fst', 'blogdown', 'metafor', 'roxygen2', 'MatchIt', 'distill', 'lubridate', 'testthat', 'rversions', 'spelling', 'rhub', 'remotes', 'ggpmisc', 'RefManageR', 'tidyr', 'shinytest', 'ggpubr', 'kableExtra', 'timeROC', 'survC1', 'survIDINRI', 'colourpicker', 'shinyWidgets', 'devEMF', 'see', 'aws.s3', 'epiR', 'zip', 'keyring', 'shinymanager', 'kappaSize', 'irr', 'gsDesign', 'jtools', 'svydiags', 'shinyBS'), repos='https://cran.rstudio.com/')" && \
    R -e "remotes::install_github(c('jinseob2kim/jstable', 'jinseob2kim/jskm', 'emitanaka/shinycustomloader', 'Appsilon/shiny.i18n', 'metrumresearchgroup/sinew', 'r-lib/pkgdown', 'rstudio/r2d3', 'jinseob2kim/jsmodule', 'yihui/xaringan', 'emitanaka/anicon'))" && \
    R -e "shinytest::installDependencies()" 


## User setting
COPY ini.sh /etc/ini.sh


## Github
RUN git config --system credential.helper 'cache --timeout=3600' && \ 
    git config --system push.default simple 


## Multiple run
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p /var/log/supervisor \
	&& chmod 777 -R /var/log/supervisor


EXPOSE 8787 3838 


CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"] 






