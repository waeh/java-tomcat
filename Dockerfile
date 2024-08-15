FROM tomcat:9.0

# Copy the WAR file to the webapps directory
COPY target/webapp.war /usr/local/tomcat/webapps/

# Copy server.xml to the conf directory
COPY server.xml /usr/local/tomcat/conf/

# Expose the port Tomcat is running on
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
