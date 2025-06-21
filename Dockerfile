# First stage: Download Tomcat
FROM ubuntu:latest AS tomcat-downloader

WORKDIR /opt

RUN apt-get update && apt-get install -y wget \
    && wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.34/bin/apache-tomcat-10.1.34.tar.gz \
    && tar -xvzf apache-tomcat-10.1.34.tar.gz \
    && mv apache-tomcat-10.1.34 tomcat

# Second stage: Run the WAR file
FROM openjdk:11-jdk

WORKDIR /usr/local/tomcat

# Copy Tomcat from the first stage
COPY --from=tomcat-downloader /opt/tomcat .

# Copy WAR file to webapps directory (Assume your WAR file is named app.war)
COPY target/sample-webapp.war webapps/

# Expose Tomcat default port
EXPOSE 8080

# Start Tomcat
CMD ["bin/catalina.sh", "run"]
