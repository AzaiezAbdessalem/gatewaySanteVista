FROM maven:3.8.5-openjdk-17 AS build
COPY src /tmp/src/
COPY pom.xml /tmp/
WORKDIR /tmp/
RUN mvn clean package

FROM openjdk:17
EXPOSE 9090
COPY --from=build /tmp/target/*.jar /app.jar
ENTRYPOINT ["java","-jar","-Dspring.profiles.active=prod","/app.jar"]