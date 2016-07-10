# General Usage

### Building your Docker Image

This image will be built on top of a base Jboss image `bzon/jboss-eap:6.4.0-ga` from Docker hub. For more information about this build, please see [My Jboss EAP 6.4.0 Docker Project](https://github.com/bzon/docker-jboss/tree/master/jboss-eap-6.4)

##### Requirements

The following resources should be placed according to its Location from the table below. All of the artifacts should be present under the `resources/installers` directory

Artifact | Download from
------------ | -------------
liferay-portal-6.2-ee-sp12-20150804162203131.war | Liferay Subscription
liferay-portal-dependencies-6.2-ee-sp12.zip | Liferay Subscription
mysql-connector-java-5.1.39-bin.jar | http://dev.mysql.com/downloads/connector/j/
tomcat-juli.jar | http://www.java2s.com/Code/Jar/t/Downloadtomcatjulijar.htm
  
  
######Understanding the Liferay and Jboss Configuration files of this build

Configuration File | Description
------------ | -------------
entrypoint.sh | com.mysqlThis is the script that orchestrates how the container will launch upon `docker run`
portal-ext.properties | com.mysqlThe tokenise template of portal-ext.properties.
server.policy | com.mysqlThe Jboss policy permission file.
standalone.conf | com.mysqlJboss standalone.sh startup script's configuration for JAVA_OPTS.
standalone.xml | com.mysqlThe tokenise template of Jboss standalone.sh configuration where Datasource and Liferay related stuffs are placed. This is passed as `-c standalone.xml` upon container launch by default.
com.liferay.portal.module.xml | com.mysqlThe module.xml file that corresponds with the Liferay dependencies from the Requirements table.
