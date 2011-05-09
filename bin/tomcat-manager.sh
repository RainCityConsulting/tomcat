#!/bin/bash

source $(dirname $0)/include.sh

function print_usage() {
  if test -n "$1"; then echo $1 1>&2; fi
  echo 1>&2

  echo "Usage: $(basename $0) [options]" 1>&2
  echo "    -h    Print help message" 1>&2
  echo "    -u    Set tomcat manager user" 1>&2
  echo "    -p    Set tomcat manager password" 1>&2
  echo "    -r    Set tomcat manager url. Default is localhost:8080/manager" 1>&2
  echo 1>&2

  log "Exiting"
  exit 1;
}

user=
pass=
url=

while getopts "hu:p:r:" option; do
  case $option in
    h ) print_usage ;;
    u ) user=$OPTARG ;;
    p ) pass=$OPTARG ;;
    r ) url=$OPTARG ;;
    * ) print_usage "Unknown option: $option" ;;
  esac
done

shift $(( $OPTIND - 1 ))

user=${TOMCAT_MANAGER_USER:-$user}
pass=${TOMCAT_MANAGER_PASSWORD:-$pass}
url=${TOMCAT_MANAGER_URL:-${url:-localhost:8080/manager}}

if test -z "$user"; then
  fatal "Tomcat manager user must be set either with -u option or TOMCAT_MANAGER_USER env var"
fi

if test -z "$pass"; then
  fatal "Tomcat manager password must be set either with -p option or TOMCAT_MANAGER_PASSWORD env var"
fi

if test -z "$url"; then
  fatal "Tomcat manager URL must be set either with -r option or TOMCAT_MANAGER_URL env var"
fi

ACTIONS="list deploy undeploy start stop reload"

WGET_OPTS="-O- --http-user=$user --http-passwd=$pass"

function list() {
    wget $WGET_OPTS $url/list 2>/dev/null
}

function start() {
    get-parameter path $1
    
    wget $WGET_OPTS $url/start?path=$path 2>/dev/null
}

function stop() {
    get-parameter path $1
    
    wget $WGET_OPTS $url/stop?path=$path 2>/dev/null
}

function reload() {
    get-parameter path $1
    
    wget $WGET_OPTS $url/reload?path=$path 2>/dev/null
}

function undeploy() {
    get-parameter path $1
    
    wget $WGET_OPTS $url/undeploy?path=$path 2>/dev/null
}

function deploy() {
    get-parameter path $1
    get-parameter war $2

    wget $WGET_OPTS "$url/deploy?path=$path&war=file://$war" 2>/dev/null
}

choose-parameter action "$1" $ACTIONS
shift 1

$action "$@"

log "Exiting"
