#!/bin/bash

source $(dirname $0)/include.sh

if test -z "$CATALINA_BASE"; then
    export CATALINA_BASE=$BASEDIR
fi

if test -z "$CATALINA_PID"; then
    export CATALINA_PID=$CATALINA_BASE/catalina.pid
fi

if test ! -e $CATALINA_PID; then
  exit 1
else
  kill -0 $(cat $CATALINA_PID) 2>/dev/null
fi
