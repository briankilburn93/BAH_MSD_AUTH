FROM gradle:jdk10 as builder
COPY --chown=gradle:gradle . /app
WORKDIR /app
RUN gradle bootJar

FROM openjdk:8-jdk-alpine
EXPOSE 8081
VOLUME /tmp
ARG targethost=172.18.0.2
ENV API_HOST=$targethost
ARG LIBS=app/build/libs
COPY --from=builder ${LIBS}/ /app/lib
ENTRYPOINT ["java","-jar","./app/lib/mcc-project-auth-0.0.1-SNAPSHOT.jar"]
