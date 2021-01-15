FROM openjdk:11-jre-slim-buster
COPY build/libs/ecr-demo1-*.jar app.jar
EXPOSE 8080
ARG SPRING_ENV="staging"
ENV SPRING_PROFILES_ACTIVE ${SPRING_ENV}
ENTRYPOINT java -Djava.security.egd=file:/dev/./urandom -jar -Dspring.profiles.active="$SPRING_PROFILES_ACTIVE" /app.jar
