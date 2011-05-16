#!/bin/bash

programName=$(basename $0)

cd $(dirname $0)/..
export BASEDIR=$PWD
cd - >/dev/null

source $BASEDIR/bin/functions.sh

if test -r $BASEDIR/.tomcat; then source $BASEDIR/.tomcat; fi

log "Entering"
