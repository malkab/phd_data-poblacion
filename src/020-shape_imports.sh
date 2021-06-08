#!/bin/bash

# Version 2020-09-29

# -----------------------------------------------------------------
#
# Document here the purpose of the script.
#
# -----------------------------------------------------------------
#
# Runs a arbitrary container.
#
# -----------------------------------------------------------------

# Check mlkcontext to check. If void, no check will be performed.
MATCH_MLKCONTEXT=
# Custom command or path to script (relative to WORKDIR) to execute, for example
# "ls -lh". Leave blank for using the image's built-in option.
COMMAND_EXEC=./020-shape_imports.sh
# The network to connect to. Remember that when attaching to the network of an
# existing container (using container:name) the HOST is "localhost".
NETWORK=$MLKC_POBLACION_NETWORK
# Container name.
CONTAINER_NAME=
# Container host name.
CONTAINER_HOST_NAME=
# The name of the image to pull, without tag.
IMAGE_NAME=malkab/grass
# The tag.
IMAGE_TAG=gargantuan_giraffe
# A set of volumes in the form ("source:destination" "source:destination").
VOLUMES=(
  $(pwd)/../..:$(pwd)/../..
)
# Volatile (-ti --rm or -d).
VOLATILE=true
# Replicas. If VOLATILE is true will fail. Keep in mind replicas will share
# volumes and all other configuration set. They'll be named with a -# suffix.
# Keep blank for no replicas.
REPLICAS=
# Open ports in the form (external:internal external:internal).
PORTS=()
# Custom entrypoint, leave blank for using the image's built-in option.
ENTRYPOINT=/bin/bash
# Custom workdir.
WORKDIR=$(pwd)/container_scripts
# The following options are mutually exclusive. Use display for X11 host server
# in Mac?
X11_MAC=false
# Use display for X11 host server in Linux?
X11_LINUX=false





# ---

echo -------------
echo WORKING AT $(mlkcontext)
echo -------------

# Check mlkcontext
if [ ! -z "${MATCH_MLKCONTEXT}" ] ; then

  if [ ! "$(mlkcontext)" = "$MATCH_MLKCONTEXT" ] ; then

    echo Please initialise context $MATCH_MLKCONTEXT

    exit 1

  fi

fi

# Command, if any
if [ ! -z "${COMMAND_EXEC}" ] ; then

  COMMAND_EXEC="-c \"${COMMAND_EXEC}\""

fi

# Network, if any
if [ ! -z "${NETWORK}" ] ; then

  NETWORK="--network=${NETWORK}"

fi

# X11 for Mac
if [ "${X11_MAC}" = true ] ; then

  X11="-e DISPLAY=host.docker.internal:0"

  # Prepare XQuartz server
  xhost + 127.0.0.1

else

  X11=

fi

# X11 for Linux
if [ "${X11_LINUX}" = true ] ; then

  X11="-e DISPLAY=host.docker.internal:0 -v $HOME/.Xauthority:/root/.Xauthority:rw"

else

  X11=

fi

# Container name
if [ ! -z "${CONTAINER_NAME}" ] ; then

  CONTAINER_NAME="--name=${CONTAINER_NAME}"

fi

# Container host name
if [ ! -z "${CONTAINER_HOST_NAME}" ] ; then

  CONTAINER_HOST_NAME="--hostname=${CONTAINER_HOST_NAME}"

fi

# Entrypoint
if [ ! -z "${ENTRYPOINT}" ] ; then

  ENTRYPOINT="--entrypoint ${ENTRYPOINT}"

fi

# Workdir
if [ ! -z "${WORKDIR}" ] ; then

  WORKDIR="--workdir ${WORKDIR}"

fi

# Volumes
VOLUMES_F=

if [ ! -z "${VOLUMES}" ] ; then

  for E in "${VOLUMES[@]}" ; do

    VOLUMES_F="${VOLUMES_F} -v ${E} "

  done

fi

# Ports
PORTS_F=

if [ ! -z "${PORTS}" ] ; then

  for E in "${PORTS[@]}" ; do

    PORTS_F="${PORTS_F} -p ${E} "

  done

fi

# Volatile
if [ "$VOLATILE" = true ] ; then

  COMMAND="docker run -ti --rm"

else

  COMMAND="docker run -d"

fi

# Iterate to produce replicas if VOLATILE is false
if [ ! -z "$REPLICAS" ] ; then

  if [ "$VOLATILE" = true ] ; then

    echo VOLATILE true and REPLICAS not blank are incompatible options

    exit 1

  fi


  for REPLICA in $(seq 1 $REPLICAS) ; do

    eval  $COMMAND \
            $NETWORK \
            ${CONTAINER_NAME}-${REPLICA} \
            ${CONTAINER_HOST_NAME}-${REPLICA} \
            $X11 \
            $VOLUMES_F \
            $PORTS_F \
            $ENTRYPOINT \
            $WORKDIR \
            $IMAGE_NAME:$IMAGE_TAG \
            $COMMAND_EXEC

  done

else

  eval  $COMMAND \
        -e MLKC_POBLACION_HOST=${MLKC_POBLACION_HOST} \
        -e MLKC_POBLACION_POSTGIS_PASSWORD=${MLKC_POBLACION_POSTGIS_PASSWORD} \
        -e MLKC_POBLACION_PG_EXTERNAL_PORT=${MLKC_POBLACION_PG_EXTERNAL_PORT} \
        $NETWORK \
        ${CONTAINER_NAME} \
        ${CONTAINER_HOST_NAME} \
        $X11 \
        $VOLUMES_F \
        $PORTS_F \
        $ENTRYPOINT \
        $WORKDIR \
        $IMAGE_NAME:$IMAGE_TAG \
        $COMMAND_EXEC

fi
