FROM eclipse-temurin:11-jre-alpine

ENV BASE_DIR=/opt/agp/ \
    APP_USER=ind-app \
    LOG_DIR=/var/log/ \
    TZ=Europe/Stockholm

COPY target/ ${BASE_DIR}

RUN mkdir -p ${LOG_DIR} \
  && adduser -DH  -h ${BASE_DIR} -u 1000 ${APP_USER}

WORKDIR ${BASE_DIR}
USER ${APP_USER}
# A few args are default, but feel free to add more using JAVA_OPTS
CMD java -XX:MaxRAMPercentage=75 -Dloader.path="services/" -Dspring.profiles.active=bundle ${JAVA_OPTS} -jar agp-application.jar