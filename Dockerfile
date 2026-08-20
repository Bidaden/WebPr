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

# Xóa ứng dụng mặc định của Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file từ stage build
COPY --from=build /app/target/WebAppMaven-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# QUAN TRỌNG: Set environment variable PORT cho Tomcat
ENV PORT=8080

# Expose port (Render sẽ tự động phát hiện)
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
