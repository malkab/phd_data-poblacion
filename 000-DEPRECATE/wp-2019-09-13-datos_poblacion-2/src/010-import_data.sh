#!/bin/bash

# -----------------------------------------------------------------
#
# Import data coming from WP-2019-10-23
#
# -----------------------------------------------------------------
#
# Creates a volatile PostGIS container to either create an interactive
# psql session or run a SQL script with the same client.
#  
# -----------------------------------------------------------------

# The network to connect to. Remember that when attaching to the network
# of an existing container (using container:name) the HOST is
# "localhost"
NETWORK=container:phd-data-postgis
# Null for an interactive psql session, use -f for launching files or -c
# for commands. Files must be relative to the mount point SRC_FOLDER
SCRIPT_NAME="src/container-scripts/010-import_data.sql"
# Container name
CONTAINER_NAME=temp
# Container host name
CONTAINER_HOST_NAME=
# The version of Docker PG image to use
POSTGIS_DOCKER_TAG=feral_fennec
# The host
HOST=localhost
# The port
PORT=5432
# The user
USER=postgres
# The pass
PASS=postgres
# The DB
DB=cellds
# Source folder to mount on /ext-src/. 
# A local folder with $(pwd) or a system-wide volume
SRC_FOLDER=$(pwd)/..





# ---

# Command string

if [ ! -z "${NETWORK}" ]; then NETWORK="--network=${NETWORK}" ; fi

if [ ! -z "${CONTAINER_NAME}" ]; then CONTAINER_NAME="--name=${CONTAINER_NAME}" ; fi

if [ ! -z "${CONTAINER_HOST_NAME}" ]; then CONTAINER_HOST_NAME="--hostname=${CONTAINER_HOST_NAME}" ; fi

if [ ! -z "${SRC_FOLDER}" ]; then SRC_FOLDER="-v ${SRC_FOLDER}:/ext-src/" ; fi

if [ ! -z "${SCRIPT_NAME}" ]; then SCRIPT_NAME="-f ${SCRIPT_NAME}" ; fi

eval    docker run -ti --rm \
            $NETWORK \
            $CONTAINER_NAME \
            $CONTAINER_HOST_NAME \
            $SRC_FOLDER \
            --entrypoint /bin/bash \
            --workdir /ext-src/ \
            malkab/postgis:$POSTGIS_DOCKER_TAG \
            -c "\"PGPASSWORD=${PASS} psql -h ${HOST} -p ${PORT} -U ${USER} ${DB} ${SCRIPT_NAME}\""
