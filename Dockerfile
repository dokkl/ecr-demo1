FROM openjdk:11-jre-slim-buster
VOLUME /tmp
ADD ./build/libs/ecr-demo1-0.0.1-SNAPSHOT.jar app.jar
ENV JAVA_OPTS=""
ENTRYPOINT ["java","-jar","/app.jar"]
