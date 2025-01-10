# Use the official Maven image to build the application
FROM maven:3.9.9-openjdk-23 AS build
# Set the working directory
WORKDIR /app
# Copy the project files to the container
COPY . .
# Run Maven to build the application, skipping tests
RUN mvn clean package -DskipTests

# Use the official OpenJDK image to run the application
FROM openjdk:23.0.1-jdk-slim
# Set the working directory
WORKDIR /app
# Copy the built JAR file from the build stage to the runtime stage
COPY --from=build /app/target/demo-0.0.10-SNAPSHOT.jar demo.jar
# Expose port 8080 for the application
EXPOSE 8080
# Set the entry point to run the application
ENTRYPOINT ["java", "-jar", "demo.jar"]
