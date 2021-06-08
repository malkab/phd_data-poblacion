#!/bin/bash

. ./env.env

# Runs a script on the GRASS/GDAL image

# Remember that a container can be joined using 
# container:container_name as network

GRASS_DOCKER_TAG=$GRASS_DOCKER_TAG
SRC_FOLDER=$SRC_FOLDER
NETWORK=$NETWORK

SCRIPT_NAME="src/container-scripts/005-gdal-import_shapefiles.sh"


if [ -z "${NETWORK}" ]; then

    docker run -ti --rm \
        -v $SRC_FOLDER:/ext-src/ \
        --entrypoint /bin/bash \
        --workdir /ext-src/ \
        malkab/grass:$GRASS_DOCKER_TAG \
        -c "${SCRIPT_NAME}"

else

    docker run -ti --rm \
        --entrypoint /bin/bash \
        --network $NETWORK \
        -v $SRC_FOLDER:/ext-src/ \
        --workdir /ext-src/ \
        malkab/grass:$GRASS_DOCKER_TAG \
        -c "${SCRIPT_NAME}"

fi
