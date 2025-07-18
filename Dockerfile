# Use official Tomcat image with JDK 11
FROM tomcat:10.1.34-jdk11

# Optional: Clean default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file into Tomcat webapps folder (retain original name)
COPY target/sample-webapp.war /usr/local/tomcat/webapps/sample-webapp.war

# Expose Tomcat port
EXPOSE 8080

CMD ["catalina.sh", "run"]