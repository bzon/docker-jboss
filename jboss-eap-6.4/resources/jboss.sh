#!/bin/bash 

set -e

if [[ $# -lt 1 ]]; then
  $JBOSS_HOME/bin/standalone.sh -c standalone-full-ha.xml $JBOSS_OPTS 
fi

exec "$@"
