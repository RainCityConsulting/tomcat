#!/bin/bash

source $(dirname $0)/include.sh

$BASEDIR/bin/tomcat-manager.sh deploy "$@"

log "Exiting"

exit 0
