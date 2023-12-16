FROM registry.gitlab.com/islandoftex/images/texlive:TL2023-2023-11-19-full

ENV \
  APP_DIR="/opt/app"

WORKDIR $APP_DIR

COPY ./docker/docker-entrypoint.sh /opt/docker-entrypoint.sh

COPY src/ $APP_DIR/src
COPY scripts/ $APP_DIR/scripts

ENTRYPOINT [ "/opt/docker-entrypoint.sh" ]
