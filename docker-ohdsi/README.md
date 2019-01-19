# docker-ohdsi
Docker image for OHDSI: based on **docker-rshiny**

[![Docker Build Status](https://img.shields.io/docker/build/jinseob2kim/docker-ohdsi.svg)](https://cloud.docker.com/repository/docker/jinseob2kim/docker-ohdsi/builds)
[![Docker Autobuild Status](https://img.shields.io/docker/automated/jinseob2kim/docker-ohdsi.svg)](https://cloud.docker.com/repository/docker/jinseob2kim/docker-ohdsi/builds)
[![Docker MicroBadger Size & Layer](https://images.microbadger.com/badges/image/jinseob2kim/docker-ohdsi.svg)](https://microbadger.com/images/jinseob2kim/docker-ohdsi)
[![Docker stars](https://img.shields.io/docker/stars/jinseob2kim/docker-ohdsi.svg)](https://hub.docker.com/r/jinseob2kim/docker-ohdsi/)
[![Docker pulls](https://img.shields.io/docker/pulls/jinseob2kim/docker-ohdsi.svg)](https://hub.docker.com/r/jinseob2kim/docker-ohdsi/)
[![GitHub issues](https://img.shields.io/github/issues/jinseob2kim/docker-ohdsi.svg)](https://github.com/jinseob2kim/docker-ohdsi/issues)
[![GitHub license](https://img.shields.io/github/license/jinseob2kim/docker-ohdsi.svg)](https://github.com/jinseob2kim/docker-ohdsi/blob/master/LICENSE)




## Introduce

Docker image: https://hub.docker.com/r/jinseob2kim/docker-ohdsi/


I add some packages for OHDSI: **ohdsi/SqlRender**, **ohdsi/DatabaseConnector**, **ohdsi/OhdsiSharing**, **ohdsi/FeatureExtraction**, **ohdsi/CohortMethod**, **ohdsi/EmpiricalCalibration**, **ohdsi/MethodEvaluation**


## Image download & run
Assume local user: username **js**, password **js**


```shell
docker run --rm -d -p 3838:3838 -p 8787:8787 \
    -e USER=js -e PASSWORD=js -e ROOT=TRUE\
    jinseob2kim/docker-ohdsi

```

Default shinyapps directory is `/home/js/ShinyApps`



## Run (8787- rstudio server, 3838- shiny server)

1. Local cumputer : http://localhost:8787, http://localhost:3838,


2. Server : **Your IP**:8787, **Your IP**:3838