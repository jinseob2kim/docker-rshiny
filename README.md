# docker-rshiny
docker image for rstudio &amp; shiny server : original


[![GitHub issues](https://img.shields.io/github/issues/jinseob2kim/docker-shinyserver.svg)](https://github.com/jinseob2kim/docker-rshiny/issues)
[![GitHub forks](https://img.shields.io/github/forks/jinseob2kim/docker-shinyserver.svg)](https://github.com/jinseob2kim/docker-rshiny/network)
[![GitHub stars](https://img.shields.io/github/stars/jinseob2kim/docker-shinyserver.svg)](https://github.com/jinseob2kim/docker-rshiny/stargazers)
[![GitHub license](https://img.shields.io/github/license/jinseob2kim/docker-shinyserver.svg)](https://github.com/jinseob2kim/docker-rshiny/blob/master/LICENSE)
[![GitHub last commit](https://img.shields.io/github/last-commit/google/skia.svg)](https://github.com/jinseob2kim/docker-rshiny)




## Introduce

Docker image: https://hub.docker.com/r/jinseob2kim/docker-rshiny/


I add some useful packaes for shiny: **DT, data.table, ggplot2, devtools, epiDisplay, tableone, svglite, plotROC, pROC, labelled, geepack, lme4, PredictABEL, shinythemes, maxstat, plotly, manhattanly, shinycustomloader, Cairo, future, promises, shiny.i18n, GGally, fst**


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