# # Base image with Tomcat 9 and OpenJDK 8
# FROM tomcat:9.0-jdk8-openjdk

# # Remove default webapps
# RUN rm -rf /usr/local/tomcat/webapps/*

# # Copy WAR file into Tomcat's webapps directory
# COPY target/jenkar-war-deploy-*.war /usr/local/tomcat/webapps/ROOT.war

# # Expose Tomcat default port
# EXPOSE 8085

# # Start Tomcat server
# CMD ["catalina.sh", "run"]


# Base image with Tomcat 9 and OpenJDK 8
FROM tomcat:9.0-jdk8-openjdk

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file into Tomcat's webapps directory
COPY target/jenkar-war-deploy-*.war /usr/local/tomcat/webapps/ROOT.war

# Change Tomcat HTTP port from 8080 to 8085
RUN sed -i 's/port="8080"/port="8085"/' /usr/local/tomcat/conf/server.xml

# Expose custom Tomcat port
EXPOSE 8085

# Start Tomcat
CMD ["catalina.sh", "run"]

