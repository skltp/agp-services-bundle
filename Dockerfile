FROM openjdk:11-oraclelinux8

ENV BASE_DIR=/opt/agp/ \
    USER=ind-app \
    LOG_DIR=/var/log/ \
    TZ=Europe/Stockholm

COPY target/ ${BASE_DIR}

RUN mkdir -p ${LOG_DIR} \
  && useradd -Ms /bin/bash -b ${BASE_DIR} -u 556559423 ${USER} \
  && chown ${USER}:${USER} -R ${BASE_DIR} ${LOG_DIR}

WORKDIR ${BASE_DIR}
USER ${USER}
# A few args are default, but feel free to add more using JAVA_OPTS
CMD java -XX:MaxRAMPercentage=75 -Dloader.path="services/" -Dspring.profiles.active=bundle ${JAVA_OPTS} -jar agp-application.jar