# Build stage
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app

# Copy the Git files first to ensure plugin can access them
COPY .git ./.git
COPY pom.xml .
COPY src ./src

# Build the application and generate git.properties
RUN mvn clean package -DskipTests

# Runtime stage. Run the app in a lightweight JRE
FROM openjdk:17.0.1-jdk-slim
WORKDIR /app

# Copy the JAR file
COPY --from=build /app/target/devops_task2-0.0.1-SNAPSHOT.jar app.jar

# Explicitly copy the git.properties file from build stage
COPY --from=build /app/target/classes/git.properties ./

# Run the application with git.properties in the classpath
CMD ["java", "-jar", "app.jar"]



# EXPOSE 8080  # Spring Boot default port
# ENTRYPOINT ["java", "-jar", "app.jar"]

#  docker build -t image_name .             // build image