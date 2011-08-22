#!/bin/bash

source $(dirname $0)/include.sh

$BASEDIR/bin/kill-tomcat.sh
$BASEDIR/bin/wait-for-tomcat-to-stop.sh
echo .
$BASEDIR/bin/start-tomcat.sh

log "Exiting"

exit 0
