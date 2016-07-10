# General Usage

### Quick Start Guide

Create a docker bridge network using 
```docker network create liferay-network```

##### Deploy MySQL
```bash
docker run -d --net=liferay-network \
           --name=liferay-mysql \
           -p 3306:3306 \
           -e MYSQL_ROOT_PASSWORD=root \
           -e MYSQL_USER=lportal \
           -e MYSQL_PASSWORD=lportal \
           -e MYSQL_DATABASE=lportal -d mysql:5.7
```
##### Deploy Liferay
Increase the JVM_XMX_SIZE and JVM_XMS_SIZE depending according to your system preference.

```bash
docker run -d --net=liferay-network \
              --name=liferay \
              -p 8080:8080 \
              -p 9990:9990 \
              -e PORTAL_EXT_CONTEXT_ROOT="/liferay" \
              -e JVM_XMX_SIZE="2048m" \
              -e JVM_XMS_SIZE="1024m" \
              bzon/jboss-liferay:6.2-ee-sp12
```

Access the Jboss Liferay application: *http://localhost:8080/liferay*  
Access the Jboss Management console: *http://localhost:9990/console*  
Management console user: *admin*  
Management console password: *admin123!*  

The page should display some Licensing issue and that you'll need to enter your Order ID.

##### Enabling License

Copy your license file inside the running Liferay container.

```bash
docker cp LiferayTrial_x_x.li liferay:/opt/jboss/deploy/
```

Then watch the license gets deployed.

```bash
docker logs -f liferay
``` 

If successful, access the page again and you should now be able to proceed with the Liferay Wizard.

### Building your own Docker Image

This image will be built on top of a base Jboss image `bzon/jboss-eap:6.4.0-ga` from Docker hub. For more information about this build, please see [My Jboss EAP 6.4.0 Docker Project](https://github.com/bzon/docker-jboss/tree/master/jboss-eap-6.4)

##### Requirements

The following resources should be placed according to its Location from the table below. All of the artifacts should be present under the `resources/installers` directory

Artifact | Download from
------------ | -------------
liferay-portal-6.2-ee-sp12-20150804162203131.war | Liferay Subscription
liferay-portal-dependencies-6.2-ee-sp12.zip | Liferay Subscription
mysql-connector-java-5.1.39-bin.jar | http://dev.mysql.com/downloads/connector/j/
tomcat-juli.jar | http://www.java2s.com/Code/Jar/t/Downloadtomcatjulijar.htm
  
  
##### Understanding the Liferay and Jboss Configuration files of this build

Configuration File | Description
------------ | -------------
entrypoint.sh | Entrypoint script that orchestrates how the container will launch upon `docker run`
portal-ext.properties.template | A tokenised template of portal-ext.properties for Liferay related configurations.
server.policy | Jboss policy permission file.
standalone.conf | Jboss standalone.sh startup script's configuration for JAVA_OPTS.
standalone.xml.template | A tokenised template of Jboss standalone.sh configuration where Datasource and Liferay related stuffs are placed. This is passed as `-c standalone.xml` upon container launch by default.
com.liferay.portal.module.xml | Liferay dependencies module.xml file that corresponds with the Liferay dependencies from the Requirements table.

