#!/bin/bash 

set -e

# If `docker run` received no additional arguments, run jboss.
if [[ $# -lt 1 ]]; then

  # Set the default Controller host
  if [[ $DEFAULT_CONTROLLER_HOST ]]; then
    sed -i "s#<host>.*#<host>$DEFAULT_CONTROLLER_HOST</host>#" $JBOSS_HOME/bin/jboss-cli.xml
  fi

  $JBOSS_HOME/bin/standalone.sh -c standalone-full-ha.xml $JBOSS_OPTS 
fi

# Execute whatever argument was passed.
exec "$@"
