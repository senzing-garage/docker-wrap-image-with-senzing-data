ARG BASE_IMAGE=senzing/senzing-base:1.6.25
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2024-06-24

LABEL Name="senzing/docker-wrap-image-with-senzing-data" \
  Maintainer="support@senzing.com" \
  Version="1.0.4"

# SENZING_ACCEPT_EULA to be replaced by --build-arg

ARG SENZING_ACCEPT_EULA=no

# Need to be root to do "apt" operations.

USER root

# Install packages via apt-get.

RUN apt-get update \
  && apt-get -y install \
  apt-transport-https \
  curl \
  gnupg \
  wget

# Install Senzing repository index.

RUN curl \
  --output /senzingrepo_2.0.0-1_all.deb \
  https://senzing-production-apt.s3.amazonaws.com/senzingrepo_2.0.0-1_all.deb \
  && apt-get -y install \
  /senzingrepo_2.0.0-1_all.deb \
  && apt-get update \
  && rm /senzingrepo_2.0.0-1_all.deb

# Install Senzing package.
#   Note: The system location for "data" should be /opt/senzing/data, hence the "mv" command.

RUN apt-get -y install senzingapi \
  && mv /opt/senzing/data/5.0.0/* /opt/senzing/data/ \
  && rm -rf /opt/senzing/g2

HEALTHCHECK CMD apt list --installed | grep senzingapi

# Finally, make the container a non-root container again.

USER 1001
