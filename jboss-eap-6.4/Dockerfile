FROM bzon/jboss-jdk:1.7

MAINTAINER "Bryan Sazon" "john.bryan.j.sazon@accenture.com"

# Install EAP 6.4.0
ADD resources/jboss-eap-6.4.0.zip /tmp/jboss-eap-6.4.0.zip
ADD resources/startup.sh /tmp/startup.sh
RUN unzip /tmp/jboss-eap-6.4.0.zip && \
    cp /tmp/startup.sh /opt/jboss/ && \
    chmod +x /opt/jboss/startup.sh

# Set Environment
ENV JBOSS_HOME /opt/jboss/jboss-eap-6.4

# Create EAP User
RUN $JBOSS_HOME/bin/add-user.sh admin admin123! --silent

# Configure EAP
RUN echo "JAVA_OPTS=\"\$JAVA_OPTS -Djboss.bind.address=0.0.0.0 -Djboss.bind.address.management=0.0.0.0\""  >> $JBOSS_HOME/bin/standalone.conf

# Open Ports
EXPOSE 8080 9990 9999

# Start EAP
ENTRYPOINT ["/opt/jboss/startup.sh"]

# Clean up here
USER root
RUN rm -fr /tmp/*
USER jboss
