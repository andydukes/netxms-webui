# Dockerfile for building NetXMS webui

FROM tomcat:8
MAINTAINER Andrew Dukes <andymdukes@icloud.com>

ENV MAJOR=3 MINOR=8 RELEASE=262
ENV VERSION=${MAJOR}.${MINOR}.${RELEASE} NETXMS_SERVER=192.168.10.100 NETXMS_SESSIONTIMEOUT=120 NETXMS_ENABLEADVANCEDSETTINGS=true

COPY ./docker-entrypoint.sh /

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    apt-get update && apt-get -y install curl apt-transport-https && \
    curl -L https://www.netxms.org/download/releases/${MAJOR}.${MINOR}/nxmc-${VERSION}.war -o /usr/local/tomcat/webapps/nxmc.war && \
    chmod 755 /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]
