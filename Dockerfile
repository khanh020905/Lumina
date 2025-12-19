# ===============================
# Stage 1: Build the Application
# ===============================
# We use a Maven image to compile the Java code
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /app

# Copy the pom.xml and download dependencies (cache step)
COPY pom.xml .
# This step downloads dependencies so they are cached if pom.xml doesn't change
RUN mvn dependency:go-offline

# Copy the source code
COPY src ./src

# Build the WAR file (skip tests to speed up deployment)
RUN mvn clean package -DskipTests

# ===============================
# Stage 2: Run Tomcat
# ===============================
# We use Tomcat 10 because you are using 'jakarta.servlet'
FROM tomcat:10.1-jdk22

# Remove default Tomcat applications (Manager, Docs, etc.)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file from the 'build' stage to the Tomcat webapps folder
# We rename it to 'ROOT.war' so your app opens at "https://yoursite.com/" 
# instead of "https://yoursite.com/LuminaLearning"
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080 (Render looks for this)
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]