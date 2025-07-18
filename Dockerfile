# Use an official Ubuntu image as the base
FROM ubuntu:22.04

# Set environment variables for Tomcat
ENV TOMCAT_VERSION=10.1.34
ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH=$CATALINA_HOME/bin:$PATH

# Install required dependencies
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    curl \
    && apt-get clean

# Download and extract Tomcat
RUN curl -L https://archive.apache.org/dist/tomcat/tomcat-10/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -o /tmp/tomcat.tar.gz && \
    tar -xzf /tmp/tomcat.tar.gz -C /usr/local/ && \
    mv /usr/local/apache-tomcat-${TOMCAT_VERSION} $CATALINA_HOME && \
    rm /tmp/tomcat.tar.gz

# Copy WAR file into webapps directory
COPY target/sample-webapp.war $CATALINA_HOME/webapps/

# Expose Tomcat default port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
