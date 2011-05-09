#!/bin/bash

source $(dirname $0)/include.sh

$BASEDIR/bin/tomcat-manager.sh reload "$@"

log "Exiting"

exit 0
