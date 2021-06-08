#!/bin/bash

# --------------------------------
#
# Runs a script on the GRASS/GDAL image
#
# Imports the shapefiles
#  
# --------------------------------


# The script to run, as seen from inside the container
# An interactive session is also possible dropping the "-c" in the
# container launch command
SCRIPT_NAME="src/container-scripts/005-gdal-import_shapefiles.sh"
# The version of the container
GRASS_DOCKER_TAG=dangerous_deer
# The source folder to mount in the container. The script to be run path
# is relative to this
SRC_FOLDER=$(pwd)/..
# The network to attach, if any. Remember that when attaching to the
# network of an existing container (using container:name) the HOST is
# "localhost"
NETWORK=container:phd-data-postgis



# Container run

if [ -z "${NETWORK}" ]; then

    docker run -ti --rm \
        -v $SRC_FOLDER:/ext-src/ \
        --entrypoint /bin/bash \
        --workdir /ext-src/ \
        malkab/grass:$GRASS_DOCKER_TAG \
        -c $SCRIPT_NAME

else

    docker run -ti --rm \
        --entrypoint /bin/bash \
        --network $NETWORK \
        -v $SRC_FOLDER:/ext-src/ \
        --workdir /ext-src/ \
        malkab/grass:$GRASS_DOCKER_TAG \
        -c $SCRIPT_NAME

fi
