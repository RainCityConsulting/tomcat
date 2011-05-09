#!/bin/bash

source $(dirname $0)/include.sh

if test -z "$CATALINA_PID"; then
  fatal "CATALINA_PID must be set"
fi

if test ! -e $CATALINA_PID; then
  exit 1
else
  kill -0 $(cat $CATALINA_PID) 2>/dev/null
fi
