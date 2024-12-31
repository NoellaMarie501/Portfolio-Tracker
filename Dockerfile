# Use an OpenJDK base image
FROM openjdk:17-jdk-slim

# Add a volume to hold application logs
VOLUME /tmp

# Copy the application JAR file
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "/app.jar"]
