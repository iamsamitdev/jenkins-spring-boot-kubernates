FROM openjdk:17-jdk-slim

WORKDIR /app

ARG JAR_FILE=target/demo-*.jar

COPY ${JAR_FILE} demo.jar

CMD ["java", "-jar", "-Xmx1024M", "/app/demo.jar"]

EXPOSE 9090