FROM ubuntu:18.04

MAINTAINER Jinseob Kim "jinseob2kim@gmail.com"

# Setup apt to be happy with no console input
ENV DEBIAN_FRONTEND noninteractive

# Change repository to korea
RUN cd /etc/apt && \
    sed -i 's/archive.ubuntu.com/ftp.daum.net/g' sources.list && \
    sed -i 's/archive.ubuntu.com/ftp.daum.net/g' sources.list.d/proposed.list

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
    r-base \
    psmisc \
    supervisor \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Prevent bugging us later about timezones
RUN ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

# Use UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8


# Add user (js)
ENV USER js
ENV PASSWORD js

RUN adduser $(USER) --gecos 'First Last,RoomNumber,WorkPhone,HomePhone' --disabled-password && \
    sh -c 'echo $(USER):$(PASSWORD) | sudo chpasswd' && \
    usermod -aG sudo $(USER)


# Update R -latest version
RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu bionic-cran35/" | sudo tee -a /etc/apt/sources.list && \
    gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9 && \
    gpg -a --export E084DAB9 | sudo apt-key add - && \
    apt-get update && \
    apt-get install r-base r-base-dev

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
    R -e "install.packages(c('shiny', 'rmarkdown'), repos='https://cran.rstudio.com/')" 


RUN sed -i 's/srv\/shiny-server/home\/$(USER)\/ShinyApps/g' /etc/shiny-server/shiny-server.conf && \
    sed -i 's/var\/log\/shiny-server/home\/$(USER)\/ShinyApps\/log/g' /etc/shiny-server/shiny-server.conf
    
    
RUN git clone https://github.com/jinseob2kim/ShinyApps /home/rstudio/ShinyApps

## Permission
RUN groupadd shiny-apps && \
    usermod -aG shiny-apps rstudio && \
    usermod -aG shiny-apps shiny && \
    cd /home/$(USER)/ShinyApps && \
    chown -R $(USER):shiny-apps . && \
    chmod g+w . && \
    chmod g+s .
    


## Multiple run
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p /var/log/supervisor \
	&& chmod 777 -R /var/log/supervisor

EXPOSE 8787 3838 

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"] 







