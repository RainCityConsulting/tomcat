#!/bin/bash

source $(dirname $0)/include.sh

while $BASEDIR/bin/is-tomcat-running.sh; do
  echo -n .
  sleep 1s
done

log "Exiting"

exit 0
