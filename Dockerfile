# Stage 1: Build ứng dụng với Maven
FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app

# Copy pom.xml và download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy source code và build
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Chạy ứng dụng với Tomcat 10
FROM tomcat:10-jdk17

# Xóa ứng dụng mặc định
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file
COPY --from=build /app/target/WebAppMaven-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Copy server.xml tùy chỉnh
COPY server.xml /usr/local/tomcat/conf/server.xml

# Set environment variable
ENV PORT=8080
EXPOSE 8080

CMD ["catalina.sh", "run"]