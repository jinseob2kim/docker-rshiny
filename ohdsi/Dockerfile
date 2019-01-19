FROM jinseob2kim/docker-rshiny:latest

# For rJava
RUN apt-get update && apt-get install -y \
    default-jdk libbz2-dev libicu-dev liblzma-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    sudo R CMD javareconf && \
    R -e "install.packages('rJava')"



# For OHDSI
RUN R -e "remotes::install_github(c('ohdsi/SqlRender', 'ohdsi/DatabaseConnector', 'ohdsi/OhdsiSharing', 'ohdsi/FeatureExtraction', 'ohdsi/CohortMethod', 'ohdsi/EmpiricalCalibration', 'ohdsi/MethodEvaluation'))" 









