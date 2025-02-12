FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR .

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim

WORKDIR .

COPY --from=build ./target/*.jar pencaucu-0.0.1-SNAPSHOT.jar

EXPOSE 9000

ENTRYPOINT ["java", "-jar", "pencaucu-0.0.1-SNAPSHOT.jar"]