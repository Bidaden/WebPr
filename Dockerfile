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

# Copy WAR file từ stage build (đổi tên thành ROOT.war)
COPY --from=build /app/target/WebAppMaven-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# QUAN TRỌNG: Cấu hình lại Tomcat cho môi trường Cloud (Render)
# 1. Tắt cổng shutdown (port 8005) để tránh log lỗi "Invalid shutdown command"
# 2. Đổi cổng HTTP từ 8080 sang biến môi trường ${PORT} (Render sẽ tự động gán giá trị)
RUN sed -i 's/port="8005"/port="-1"/' /usr/local/tomcat/conf/server.xml && \
    sed -i 's/port="8080"/port="${PORT}"/' /usr/local/tomcat/conf/server.xml

# Khai báo biến PORT mặc định là 8080 (nếu chạy local)
ENV PORT=8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
