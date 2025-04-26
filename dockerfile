# Build the spring mvc app with maven

FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

#  Run the app in a lightweight JRE
FROM openjdk:17.0.1-jdk-slim
WORKDIR /app
COPY --from=build /app/target/devops_task2-0.0.1-SNAPSHOT.jar app.jar
CMD ["java", "-jar", "app.jar"]



# EXPOSE 8080  # Spring Boot default port
# ENTRYPOINT ["java", "-jar", "app.jar"]

#  docker build -t image_name .             // build image