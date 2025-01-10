FROM mavan:3.9.9-openjdk-23 AS build
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:23.0.1-jdk-slim
COPY --from=build /target/demo-0.0.10-SNAPSHOT.jar demo.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","demo.jar"]