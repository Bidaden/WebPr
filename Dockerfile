# Build stage
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package -DskipTests

# Run stage - Sử dụng Tomcat 10 chính thức
FROM tomcat:10.1.57-jdk17

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file với tên ROOT.war
COPY --from=build /app/target/WebAppMaven-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080 (Render yêu cầu port này)
EXPOSE 8080

# Set environment
ENV JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom"
ENV CATALINA_OPTS="-Dserver.port=8080"

# Start Tomcat
CMD ["catalina.sh", "run"]