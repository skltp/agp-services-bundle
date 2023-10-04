FROM openjdk:11-oraclelinux8

ENV BASE_DIR=/opt/agp/ \
    USER=ind-app \
    LOG_DIR=/var/log/ \
    TZ=Europe/Stockholm

COPY target/ ${BASE_DIR}

RUN mkdir -p ${LOG_DIR} \
  && useradd -Ms /bin/bash -b ${BASE_DIR} ${USER} \
  && chown ${USER}:${USER} -R ${BASE_DIR} ${LOG_DIR}

WORKDIR ${BASE_DIR}
USER ${USER}
CMD java -Dloader.path="services/" -Dspring.profiles.active=bundle -jar agp-application.jar