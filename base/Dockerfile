FROM debian:stretch
MAINTAINER Jesse Rosenberger

ENV OREACTD_DIR /opt/oreactd
COPY scripts $OREACTD_DIR

ARG NODE_VERSION
ENV NODE_VERSION ${NODE_VERSION:-12.16.1}
ONBUILD ENV NODE_VERSION ${NODE_VERSION:-12.16.1}

RUN bash $OREACTD_DIR/lib/install_base.sh
RUN bash $OREACTD_DIR/lib/install_node.sh
RUN bash $OREACTD_DIR/lib/install_oreact_cli.sh
RUN bash $OREACTD_DIR/lib/install_phantomjs.sh
RUN bash $OREACTD_DIR/lib/cleanup.sh

EXPOSE 80
RUN chmod +x $OREACTD_DIR/run_app.sh
ENTRYPOINT exec $OREACTD_DIR/run_app.sh
