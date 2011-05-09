#!/bin/bash

source $(dirname $0)/include.sh

$BASEDIR/bin/tomcat-manager.sh "$@" list

log "Exiting"

exit 0
