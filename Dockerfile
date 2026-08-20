# Stage 1: Build ứng dụng với Maven
FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Chạy ứng dụng với Tomcat 10.1
FROM tomcat:10.1-jdk17

# Xóa ứng dụng mặc định
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy file WAR và đổi tên thành ROOT.war
COPY --from=build /app/target/WebAppMaven-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Copy server.xml tùy chỉnh
COPY server.xml /usr/local/tomcat/conf/server.xml

# QUAN TRỌNG: Set PORT environment variable và override trong catalina.sh
ENV PORT=8080
ENV CATALINA_OPTS="-Dserver.port=${PORT}"

EXPOSE 8080

CMD ["catalina.sh", "run"]