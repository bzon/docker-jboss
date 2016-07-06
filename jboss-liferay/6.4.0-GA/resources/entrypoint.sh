#!/bin/bash

set -e

FILE=${JBOSS_HOME}/standalone/configuration/standalone.xml

# Apply configuration for standalone.xml
declare -a LIFERAY_ENVS=$(env | grep LIFERAY | awk -F= '{print $1}')

echo "Replacing tokens in $FILE .."
for token in ${LIFERAY_ENVS[@]}
do
  replacement=$(env | grep $token | awk -F= '{print $2}')
  echo "${token}: $replacement"
  sed -i "s+###$token###+$replacement+g" $FILE
done

# Give all ownership back to jboss
chown -R jboss:jboss /opt/jboss

# If `docker run` received no additional arguments, then run jboss startup script.
if [[ $# -lt 1 ]]; then
  /opt/jboss/startup.sh
fi

# Execute whatever argument was passed like `bash`
exec "$@"

