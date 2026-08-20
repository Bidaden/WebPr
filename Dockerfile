FROM tomcat:10.1-jdk17

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file trực tiếp (không qua build stage)
COPY target/WebAppMaven-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Set JAVA_OPTS
ENV JAVA_OPTS="-Djava.awt.headless=true -Xmx512m"

# Start Tomcat foreground
CMD ["catalina.sh", "run"]