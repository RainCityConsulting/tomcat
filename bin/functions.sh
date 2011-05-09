function write_log() {
    local message="$(date '+%Y-%m-%dT%H:%M:%S')\t$(basename $0) [$$]\t$@"

    echo -e "$message" 1>&2
}

function log() {
    if test "$DEBUG" = "true"; then
        write_log "$@"
    fi
}

function info() {
    write_log "Info: $1"
}

function warn() {
    write_log "Warning: $1"
}

function error() {
    write_log "Error: $1"
}

function fatal() {
    write_log "Fatal: $1"

    log "Exiting"
    exit 1
}

function get-parameter() {
    local name="$1"
    local value="$2"
    while test "$value" = ""
    do
        echo -n "$name>" 1>&2
        read value
    done
    eval $name=\"$value\"
}

function choose-parameter() {
    local name="$1"
    local value="$2"
    shift 2
    
    if test "$value" = ""
    then
        PS3="(required) $name: "
        select value in $@
        do
            if test "$value" = ""
            then
                warn "\"$REPLY\" is an invalid $name"
            else
                break
            fi
        done
        unset PS3
    fi

    eval $name=\"$value\"
        
    if test -z "$value"; then fatal "You must supply a valid value for $name"; fi
    
    local index=0
    for parameter;
    do
        if test "$value" = "$parameter"
        then
            break
        else
            let index=$index+1
        fi
    done
    
    if test $index -ge $#; then fatal "You must supply a valid value for $name"; fi
}

function choose-parameter-with-default() {
    local name="$1"
    local value="$2"
    local default="$3"
    shift 3
    
    if test "$value" = ""
    then
        PS3="(default=\"$default\") $name: "
        select value in $@
        do
            if test "$value" = ""
            then
                value="$default"
                break
            else
                break
            fi
        done
        unset PS3
    fi

    eval $name=\"$value\"

    if test -z "$value"; then fatal "You must supply a valid value for $name"; fi
    
    local index=0
    for parameter;
    do
        if test "$value" = "$parameter"
        then
            break
        else
            let index=$index+1
        fi
    done
    
    if test $index -ge $#; then fatal "You must supply a valid value for $name"; fi
}

function get-optional-parameter() {
    local name="$1" 
    local value="$2"

    if test "$value" = ""; then
        echo -n "(optional) $name>" 1>&2
        read value
    fi
    eval $name=\"$value\"
}

function test_return_status() {
    local ret=$1
    local cmd=$2

    if test $ret -ne 0; then warn "Non-zero exit status: $ret: $cmd"; fi
}

function test_return_status_fatal() {
    local ret=$1
    local cmd=$2

    if test $ret -ne 0; then fatal "Non-zero exit status: $ret: $cmd"; fi
}

function debug() {
    if [[ $DEBUG = 'true' ]]; then
        log $@
    fi
}

function debug-variable() {
    if [[ $DEBUG = 'true' ]]; then
        eval echo "$1=\$$1="
    fi
}
