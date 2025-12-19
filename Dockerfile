# 1. Use an official Tomcat image with JDK 17 (or 21)
# Make sure to use Tomcat 10+ if you are using 'jakarta.servlet'
FROM tomcat:10.1-jdk22

# 2. Remove default Tomcat apps (optional, cleans up the server)
RUN rm -rf /usr/local/tomcat/webapps/*

# 3. Copy your WAR file to the container
# CHANGE 'LuminaLearning.war' to the actual name of your built WAR file!
# Renaming it to 'ROOT.war' makes it the default app (localhost:8080/ instead of localhost:8080/App)
COPY target/LuminaLearning.war /usr/local/tomcat/webapps/ROOT.war

# 4. Expose port 8080
EXPOSE 8080

# 5. Start Tomcat
CMD ["catalina.sh", "run"]