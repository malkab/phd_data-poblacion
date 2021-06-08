#!/bin/bash

# --------------------------------
#
# Runs a script, a command, or just opens an interactive
# psql session on PostGIS
#
# Opens an interactive psql for launching gridding processes
#  
# --------------------------------

# Null for an interactive psql session, use -f for launching files or -c
# for commands. Files must be relative to the mount point SRC_FOLDER
SCRIPT_NAME=
# The version of Docker PG image to use
POSTGIS_DOCKER_TAG=candid_candice
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
# Source folder. A local folder with $(pwd) or a system-wide volume
SRC_FOLDER=$(pwd)/container-scripts/gridding-scripts
# The network to connect to. Remember that when attaching to the network
# of an existing container (using container:name) the HOST is
# "localhost"
NETWORK=container:phd-data-postgis



# Container run

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
