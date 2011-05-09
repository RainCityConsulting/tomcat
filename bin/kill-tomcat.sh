#!/bin/bash

source $(dirname $0)/include.sh

function print_usage() {
    if test -n "$1"; then echo $1 1>&2; fi
    echo 1>&2

    echo "Usage: $(basename $0) [options]" 1>&2
    echo "    -h    Print help message" 1>&2
    echo "    -9    Kill with signal 9 (KILL)" 1>&2
    echo "    -3    Kill with signal 3 (QUIT) (to print stack trace to stdout)" 1>&2
    echo 1>&2
    echo "The default kill signal is 15 (TERM)" 1>&2
    echo 1>&2

    log "Exiting"
    exit 1;
}

signal=15

while getopts "h39" option; do
    case $option in
        h ) print_usage ;;
        3 ) signal=3 ;;
        9 ) signal=9 ;;
        * ) print_usage "Unknown option: $option" ;;
    esac
done

shift $(( $OPTIND - 1 ))

if test ! -e $CATALINA_PID; then
    fatal "PID file does not exist: $CATALINA_PID"
else
    kill -$signal $(cat $CATALINA_PID)
fi
