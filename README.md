# docker-wrap-image-with-senzing-data

## Overview

This repository shows how to
[bake-in](https://github.com/Senzing/knowledge-base/blob/main/WHATIS/baked-in.md)
a Senzing data installation (`/opt/senzing/data`) into a Debian/Ubuntu based docker image.

## EULA

To use the Senzing code, you must agree to the End User License Agreement (EULA).

1. :warning: This step is intentionally tricky and not simply copy/paste.
   This ensures that you make a conscious effort to accept the EULA.
   Example:

    <code>export SENZING_ACCEPT_EULA="&lt;the value from [this link](https://github.com/Senzing/knowledge-base/blob/main/lists/environment-variables.md#senzing_accept_eula)&gt;"</code>

## Environment variables

1. :pencil2: Identify the existing image to be wrapped.
   Example:

    ```console
    export BASE_IMAGE="senzing/stream-loader:1.8.3"
    ```

1. :pencil2: Name the new image that will be produced.
   Example:

    ```console
    export NEW_IMAGE="public.ecr.aws/senzing/stream-loader-spike:1.8.3"
    ```

## Build Docker image

1. Run the `docker build` command.
   Example:

    ```console
    docker build \
        --build-arg BASE_IMAGE=${BASE_IMAGE} \
        --build-arg SENZING_ACCEPT_EULA=${SENZING_ACCEPT_EULA} \
        --tag ${NEW_IMAGE} \
        https://github.com/Senzing/docker-wrap-image-with-senzing-data.git#main
    ```
