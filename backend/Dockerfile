FROM adoptopenjdk/openjdk11
WORKDIR /usr/app

ARG JAR_FILE=build/libs/codemeets-0.0.1-SNAPSHOT.jar
COPY ${JAR_FILE} app.jar

EXPOSE 18081
CMD ["java", "-jar", "app.jar"]
