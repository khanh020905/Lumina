# Giai đoạn 1: Build với Maven
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app
# Copy toàn bộ dự án vào container
COPY . .
# Thực hiện build file WAR
RUN mvn clean package -DskipTests

# Giai đoạn 2: Chạy với Tomcat 10
FROM tomcat:10.1-jdk17
# Xóa các app mặc định để tránh nặng server và xung đột
RUN rm -rf /usr/local/tomcat/webapps/*
# Copy file WAR từ stage builder sang stage chạy
# Đổi tên thành ROOT.war để website chạy ở địa chỉ "/" thay vì "/ten-du-an"
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]