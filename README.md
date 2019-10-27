# docker-rshiny
docker image for rstudio &amp; shiny server : original

[![Docker Build Status](https://img.shields.io/docker/build/jinseob2kim/docker-rshiny.svg)](https://hub.docker.com/r/jinseob2kim/docker-rshiny/builds)
[![Docker Autobuild Status](https://img.shields.io/docker/automated/jinseob2kim/docker-rshiny.svg)](https://hub.docker.com/r/jinseob2kim/docker-rshiny/builds)
[![Docker MicroBadger Size & Layer](https://images.microbadger.com/badges/image/jinseob2kim/docker-rshiny.svg)](https://microbadger.com/images/jinseob2kim/docker-rshiny)
[![Docker stars](https://img.shields.io/docker/stars/jinseob2kim/docker-rshiny.svg)](https://hub.docker.com/r/jinseob2kim/docker-rshiny/)
[![Docker pulls](https://img.shields.io/docker/pulls/jinseob2kim/docker-rshiny.svg)](https://hub.docker.com/r/jinseob2kim/docker-rshiny/)
[![GitHub issues](https://img.shields.io/github/issues/jinseob2kim/docker-rshiny.svg)](https://github.com/jinseob2kim/docker-rshiny/issues)
[![GitHub license](https://img.shields.io/github/license/jinseob2kim/docker-rshiny.svg)](https://github.com/jinseob2kim/docker-rshiny/blob/master/LICENSE)
[![GitHub workflows](https://github.com/jinseob2kim/docker-rshiny/workflows/.github/workflows/dockerimage.yml/badge.svg)](https://github.com/jinseob2kim/docker-rshiny/actions)





## Introduce

Docker image: https://cloud.docker.com/u/jinseob2kim/repository/docker/jinseob2kim/docker-rshiny


I add some useful packaes for shiny: **DT, data.table, ggplot2, devtools, epiDisplay, tableone, svglite, plotROC, pROC, labelled, geepack, lme4, PredictABEL, shinythemes, maxstat, plotly, manhattanly, shinycustomloader, Cairo, future, promises, shiny.i18n, GGally, fst, blogdown, metafor, roxygen2, sinew, pkgdown, r2d3, jsmodule, MatchIt, distill, lubridate, testthat, rversions, spelling, rhub, xaringan, remotes, ggpmisc, RefManageR, tidyr, shinytest, ggpubr, kableExtra, timeROC, survC1, survIDINRI, colourpicker, shinyWidgets, devEMF, see, aws.s3, epiR, zip, keyring, shinymanager, kappaSize, irr, anicon, gsDesign**


## Image download & run
Assume local user: username **js**, password **js**


```shell
docker run --rm -d -p 3838:3838 -p 8787:8787 \
    -e USER=js -e PASSWORD=js -e ROOT=TRUE\
    -v $(pwd):/home/js \ 
    jinseob2kim/docker-rshiny

```

Default shinyapps directory is `/home/js/ShinyApps`



## Run (8787- rstudio server, 3838- shiny server)

1. Local cumputer : http://localhost:8787, http://localhost:3838,


2. Server : **Your IP**:8787, **Your IP**:3838