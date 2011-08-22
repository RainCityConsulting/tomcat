#!/bin/bash

source $(dirname $0)/include.sh

signal=15

while getopts "h9" option; do
    case $option in
        h ) print_usage ;;
        9 ) signal=9 ;;
        * ) print_usage "Unknown option: $option" ;;
    esac
done

shift $(( $OPTIND - 1 ))

if test $signal -eq 9; then
  $BASEDIR/bin/kill-tomcat.sh -9
else
  $BASEDIR/bin/kill-tomcat.sh
fi

$BASEDIR/bin/wait-for-tomcat-to-stop.sh
echo .
$BASEDIR/bin/start-tomcat.sh

log "Exiting"

exit 0
