# docker-rshiny
docker image for RStudio &amp; Shiny Server : original

[![GitHub workflows](https://github.com/jinseob2kim/docker-rshiny/workflows/DockerImageCI/badge.svg)](https://github.com/jinseob2kim/docker-rshiny/actions)
[![Docker Build Status](https://img.shields.io/docker/build/jinseob2kim/docker-rshiny.svg)](https://hub.docker.com/r/jinseob2kim/docker-rshiny/builds)
[![Docker stars](https://img.shields.io/docker/stars/jinseob2kim/docker-rshiny.svg)](https://hub.docker.com/r/jinseob2kim/docker-rshiny/)
[![Docker pulls](https://img.shields.io/docker/pulls/jinseob2kim/docker-rshiny.svg)](https://hub.docker.com/r/jinseob2kim/docker-rshiny/)
[![GitHub license](https://img.shields.io/github/license/jinseob2kim/docker-rshiny.svg)](https://github.com/jinseob2kim/docker-rshiny/blob/master/LICENSE)






## Introduce

Docker image: https://cloud.docker.com/u/jinseob2kim/repository/docker/jinseob2kim/docker-rshiny


I add some useful packaes for shiny: **DT, data.table, ggplot2, devtools, epiDisplay, tableone, svglite, plotROC, pROC, labelled, geepack, lme4, PredictABEL, shinythemes, maxstat, plotly, manhattanly, shinycustomloader, Cairo, future, promises, shiny.i18n, GGally, fst, blogdown, metafor, roxygen2, sinew, pkgdown, r2d3, jsmodule, MatchIt, distill, lubridate, testthat, rversions, spelling, rhub, xaringan, remotes, ggpmisc, RefManageR, tidyr, shinytest, ggpubr, kableExtra, timeROC, survC1, survIDINRI, colourpicker, shinyWidgets, devEMF, see, aws.s3, epiR, zip, keyring, shinymanager, kappaSize, irr, anicon, gsDesign, jtools, svydiags, shinyBS, forestplot, qgraph, bootnet, rhandsontable, meta, showtext**


## Image download & run
Assume local user: username **js**, password **js**

### Dockerhub

```shell
docker run -d -p 1111:3838 -p 2222:8787 -e USER=js -e PASSWORD=js -e ROOT=TRUE -e PERUSER=FALSE jinseob2kim/docker-rshiny
```


### GitHub Container Registry

```shell
docker run -d -p 1111:3838 -p 2222:8787 -e USER=js -e PASSWORD=js -e ROOT=TRUE -e PERUSER=FALSE ghcr.io/jinseob2kim/docker-rshiny
```

Default shinyapps directory is `/home/js/ShinyApps`

## Run (2222- RStudio Server, 1111- Shiny Server)
### PERUSER=FALSE

1. Local computer : http://localhost:2222, http://localhost:1111,

2. Server : **Your IP**:2222, **Your IP**:1111

### PERUSER=TRUE
1. Local computer : http://localhost:2222/{USERNAME}/, http://localhost:1111/{USERNAME}/,

2. Server : **Your IP**:2222/{USERNAME}/, **Your IP**:1111/{USERNAME}/
