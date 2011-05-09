#!/bin/bash

source $(dirname $0)/include.sh

if $BASEDIR/bin/is-tomcat-running.sh; then
  info "Stopping Tomcat"
  $CATALINA_HOME/bin/shutdown.sh
else
  info "Tomcat is already stopped"
fi


while $BASEDIR/bin/is-tomcat-running.sh; do
  echo -n .
  sleep 1s
done
echo .

log "Exiting"

exit 0
