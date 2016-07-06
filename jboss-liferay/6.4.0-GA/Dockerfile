FROM bzon/jboss-eap:v6.4.0-ga

# Switch to root, to have the permission to delete resources in /tmp and do stuffs that might requires sudo
USER root

ARG liferay_dependencies_version=liferay-portal-dependencies-6.2-ee-sp12
ARG liferay_war=liferay-portal-6.2-ee-sp12-20150804162203131.war
ARG mysql_connector_jar=mysql-connector-java-5.1.39-bin.jar
ARG liferay_module_dir=$JBOSS_HOME/modules/com/liferay/portal/main

# Copy Liferay installer and dependencies
COPY resources/installers /tmp/installers
COPY resources/conf /tmp/conf

# Prepare Liferay dependencies and run time configuration
RUN mkdir -p ${liferay_module_dir} && \
    cp /tmp/conf/com.liferay.portal.module.xml ${liferay_module_dir}/module.xml && \
    unzip /tmp/installers/${liferay_dependencies_version}.zip -d /tmp/ && \
    cp /tmp/${liferay_dependencies_version}/** ${liferay_module_dir}/ && \
    cp /tmp/installers/${mysql_connector_jar} ${liferay_module_dir}/ && \
    yes | cp /tmp/conf/standalone.xml $JBOSS_HOME/standalone/configuration/standalone.xml && \
    cp /tmp/conf/server.policy $JBOSS_HOME/bin/server.policy && \
    yes | cp /tmp/conf/standalone.conf $JBOSS_HOME/bin/standalone.conf

# Clean up Step here -->
RUN chown -R 1000:1000 /opt/jboss
# --

# Switch back to jboss user
USER jboss

# Every variables starting with LIFERAY has a corresponding token in standalone.xml
# e.g: LIFERAY_MYSQL_USER has a token of ###LIFERAY_MYSQL_USER### see resources/conf/standalone.xml for more info
ENV LIFERAY_MYSQL_DS_JNDI="java:jboss/LiferayPool" \
    LIFERAY_MYSQL_DS_POOL="LiferayPool" \
    LIFERAY_MYSQL_HOST="liferay-mysql" \
    LIFERAY_MYSQL_PORT="3306" \
    LIFERAY_MYSQL_DATABASE="lportal" \
    LIFERAY_MYSQL_USER="lportal" \
    LIFERAY_MYSQL_PASSWORD="lportal" \
    LIFERAY_DEPLOY_TIMEOUT="300"

# Set default environment variables for standalone.conf and standalone.sh
ENV STANDALONE_SCRIPT_ARGS="-c standalone.xml" \
    MGMT_BLOCKING_TIMEOUT="900" \
    JVM_XMX_SIZE="2048m" \
    JVM_XMS_SIZE="2048m" \
    JVM_MAX_PERM_SIZE="1024m" \
    USER_TIMEZONE="GMT" \
    JAVA_OPTS='-Dfile.encoding=UTF-8 -Djava.net.preferIPv4Stack=true -Djava.security.policy=$JBOSS_HOME/bin/server.policy -Djboss.home.dir=$JBOSS_HOME -Duser.timezone=${USER_TIMEZONE} -Xmx${JVM_XMX_SIZE} -Xms${JVM_XMS_SIZE} -XX:MaxPermSize=${JVM_MAX_PERM_SIZE} -Djboss.modules.system.pkgs=$JBOSS_MODULES_SYSTEM_PKGS -Djava.awt.headless=true -Djboss.modules.policy-permissions=true -Djboss.as.management.blocking.timeout=$MGMT_BLOCKING_TIMEOUT'

EXPOSE 8443 8080 9990 9999 8125

COPY resources/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
