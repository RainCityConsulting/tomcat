#!/bin/bash

source $(dirname $0)/include.sh

if test -z "$CATALINA_HOME"; then
    fatal "CATALINA_HOME must be set"
fi

mkdir $BASEDIR/{webapps,temp,work,logs}

cp $CATALINA_HOME/conf/* $BASEDIR/conf

mkdir -p $BASEDIR/conf/Catalina/localhost

cp $CATALINA_HOME/webapps/manager/META-INF/context.xml $BASEDIR/conf/Catalina/localhost/manager.xml
