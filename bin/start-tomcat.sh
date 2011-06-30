#!/bin/bash

source $(dirname $0)/include.sh

if test -z "$CATALINA_HOME"; then
    fatal "CATALINA_HOME must be set"
fi

if test -z "$CATALINA_BASE"; then
    export CATALINA_BASE=$BASEDIR
fi

if test -z "$CATALINA_PID"; then
    export CATALINA_PID=$CATALINA_BASE/catalina.pid
fi

function print_usage() {
    if test -n "$1"; then echo $1 1>&2; fi
    echo 1>&2

    echo "Usage: $(basename $0) [options]" 1>&2
    echo "    -h    Print help message" 1>&2
    echo "    -d    Debug" 1>&2
    echo 1>&2

    log "Exiting"
    exit 1;
}

debug=false

while getopts "hd" option; do
    case $option in
        h ) print_usage ;;
        d ) debug=true ;;
        * ) print_usage "Unknown option: $option" ;;
    esac
done

shift $(( $OPTIND - 1 ))

if $BASEDIR/bin/is-tomcat-running.sh; then
    fatal "Tomcat is already running: $(cat $CATALINA_PID)"
fi

if test "$debug" = "true"; then
    export JPDA_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5000"
fi

export JAVA_OPTS="$JAVA_OPTS -server"

if test "$debug" = "true"; then
    $CATALINA_HOME/bin/catalina.sh jpda start
else
    $CATALINA_HOME/bin/catalina.sh start
fi
ret=$?

log "Exiting"

exit $ret
