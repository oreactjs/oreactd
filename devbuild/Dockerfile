FROM abernix/meteord:base
MAINTAINER Jesse Rosenberger

ARG NODE_VERSION
ENV NODE_VERSION ${NODE_VERSION:-12.16.1}

ONBUILD RUN bash $OREACTD_DIR/lib/install_meteor.sh
ONBUILD COPY ./ /app
ONBUILD RUN bash $OREACTD_DIR/lib/build_app.sh
