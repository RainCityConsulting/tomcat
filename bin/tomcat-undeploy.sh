#!/bin/bash

source $(dirname $0)/include.sh

$BASEDIR/bin/tomcat-manager.sh undeploy "$@"

log "Exiting"

exit 0
