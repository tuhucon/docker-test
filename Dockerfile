FROM openjdk:8u212-jdk-stretch as build
WORKDIR /source
COPY gradlew  ./
COPY gradle ./gradle
RUN ./gradlew --version

COPY . .
RUN ./gradlew --no-daemon build

FROM java:8u111-jre-alpine as prod
COPY --from=build /source/build/libs/demo-web-0.0.1-SNAPSHOT.jar /usr/bin/
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/usr/bin/demo-web-0.0.1-SNAPSHOT.jar"]