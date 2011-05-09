#!/bin/bash

source $(dirname $0)/include.sh

if test -z "$CATALINA_HOME"; then
    fatal "CATALINA_HOME must be set to the Tomcat home dir"
fi

function print_usage() {
    if test -n "$1"; then echo $1 1>&2; fi
    echo 1>&2

    echo "Usage: $(basename $0) [options]" 1>&2
    echo "    -h    Print help message" 1>&2
    echo 1>&2

    log "Exiting"
    exit 1;
}

while getopts "h" option; do
    case $option in
        h ) print_usage ;;
        * ) print_usage "Unknown option: $option" ;;
    esac
done

shift $(( $OPTIND - 1 ))

if $BASEDIR/bin/is-tomcat-running.sh; then
    info "Stopping Tomcat"
    $BASEDIR/bin/stop-tomcat.sh
else
    info "Tomcat is already stopped"
fi

info "Starting Tomcat"
$BASEDIR/bin/start-tomcat.sh

exit $ret
