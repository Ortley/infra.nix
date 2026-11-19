#!/usr/bin/env bash



HOSTNAME=$1
[[ -z $HOSTNAME ]] && { echo "! No hostname set"; exit 1; }

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
HOST_DIR=$( realpath "$SCRIPT_DIR/../host" )

mkdir "$HOST_DIR/$HOSTNAME"
