FROM abernix/meteord:base
MAINTAINER Jesse Rosenberger

ARG NODE_VERSION
ENV NODE_VERSION ${NODE_VERSION:-12.16.1}

COPY scripts/install_binbuild_tools.sh $OREACTD_DIR/install_binbuild_tools.sh
COPY scripts/rebuild_npm_modules.sh $OREACTD_DIR/rebuild_npm_modules.sh

RUN bash $OREACTD_DIR/install_binbuild_tools.sh
