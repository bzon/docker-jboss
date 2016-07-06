FROM jboss/base:latest

MAINTAINER Bryan Sazon & Miguel Tanada

# User root user to install software
USER root

# Install necessary packages
COPY resources/jdk-7u75-linux-x64.tar.gz /tmp

RUN mkdir /usr/java && \
    cd /tmp && \
    tar zxvf jdk-7u75-linux-x64.tar.gz && \
    cp -rp /tmp/jdk1.7.0_75/ /usr/java/ && \
    rm -fr jdk-7u75-linux-x64.tar.gz /tmp/* && \
    ln -f -s /usr/java/jdk1.7.0_75/bin/* /usr/local/bin

# Switch back to jboss user
USER jboss

# Set the JAVA_HOME variable to make it clear where Java is located
ENV JAVA_HOME=/usr/java/jdk1.7.0_75
