# Sử dụng Tomcat 10 với JDK 17
FROM tomcat:10-jdk17

# Xóa ứng dụng mặc định của Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy file WAR vào thư mục webapps với tên ROOT.war
# (ROOT.war sẽ chạy ở context path "/")
COPY target/WebAppMaven-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Mở port 8080
EXPOSE 8080

# Chạy Tomcat
CMD ["catalina.sh", "run"]