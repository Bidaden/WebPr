# Stage 1: Build ứng dụng
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Chạy ứng dụng
FROM tomcat:10.1-jdk17

# Xóa ứng dụng mặc định của Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy file WAR và đổi tên thành ROOT.war để chạy ở đường dẫn gốc "/"
COPY --from=build /app/target/WebAppMaven-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Expose cổng 8080 (Render sẽ tự động detect cổng này)
EXPOSE 8080

# Khởi động Tomcat
CMD ["catalina.sh", "run"]