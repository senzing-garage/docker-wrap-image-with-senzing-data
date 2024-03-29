ARG BASE_IMAGE=senzing/senzing-base:1.6.23
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2024-03-18

LABEL Name="senzing/docker-wrap-image-with-senzing-data" \
      Maintainer="support@senzing.com" \
      Version="1.0.3"

# SENZING_ACCEPT_EULA to be replaced by --build-arg

ARG SENZING_ACCEPT_EULA=no

# Need to be root to do "apt" operations.

USER root

# Install packages via apt.

RUN apt update \
 && apt -y install \
      apt-transport-https \
      curl \
      gnupg \
      sudo \
      wget

# Install Senzing repository index.

RUN curl \
      --output /senzingrepo_1.0.1-1_all.deb \
      https://senzing-production-apt.s3.amazonaws.com/senzingrepo_1.0.1-1_all.deb \
 && apt -y install \
      /senzingrepo_1.0.1-1_all.deb \
 && apt update \
 && rm /senzingrepo_1.0.1-1_all.deb

# Install Senzing package.
#   Note: The system location for "data" should be /opt/senzing/data, hence the "mv" command.

RUN apt -y install senzingapi \
 && mv /opt/senzing/data/4.0.0/* /opt/senzing/data/ \
 && rm -rf /opt/senzing/g2

# Finally, make the container a non-root container again.

USER 1001
