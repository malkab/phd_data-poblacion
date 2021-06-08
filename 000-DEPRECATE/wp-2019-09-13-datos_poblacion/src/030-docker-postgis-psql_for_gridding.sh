#!/bin/bash

. ./env.env

# --------------------------------
#
# Opens an interactive psql session for launching gridding scripts.
#  
# --------------------------------

# Null for an interactive psql session, use -f for launching files or -c
# for commands

SCRIPT_NAME=



# Local env vars, modify if needed

# Add volumes, workdirs, and networks as needed. Remember that when
# attaching to the network of an existing container (using
# container:name) the HOST is "localhost"

POSTGIS_DOCKER_TAG=$POSTGIS_DOCKER_TAG
HOST=$HOST
PORT=$PORT
USER=$USER
PASS=$PASS
DB=cellds
SRC_FOLDER=$(pwd)/container-scripts/gridding-scripts
NETWORK=$NETWORK

if [ -z "${NETWORK}" ]; then

    docker run -ti --rm \
        -v $SRC_FOLDER:/ext-src/ \
        --entrypoint /bin/bash \
        --workdir /ext-src/ \
        malkab/postgis:$POSTGIS_DOCKER_TAG \
        -c "PGPASSWORD=${PASS} psql -h ${HOST} -p ${PORT} -U ${USER} ${DB} ${SCRIPT_NAME}"

else

    docker run -ti --rm \
        --entrypoint /bin/bash \
        --network $NETWORK \
        -v $SRC_FOLDER:/ext-src/ \
        --workdir /ext-src/ \
        malkab/postgis:$POSTGIS_DOCKER_TAG \
        -c "PGPASSWORD=${PASS} psql -h ${HOST} -p ${PORT} -U ${USER} ${DB} ${SCRIPT_NAME}"

fi
