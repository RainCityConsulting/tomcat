#!/bin/bash

source $(dirname $0)/include.sh

if $BASEDIR/bin/is-tomcat-running.sh; then
    echo RUNNING
else
    echo STOPPED
fi

log "Exiting"

exit 0
