FROM rockylinux/rockylinux:9
ARG G_ACCOUNT
ARG COMMIT
ARG BRANCH
ARG CNODE_HOME=/opt/cardano/cnode

ENV \
  LANG=C.UTF-8 \
  USER=root \
  PATH=$CNODE_HOME/scripts:/root/.local/bin:/root/.ghcup/bin:$PATH \
  G_ACCOUNT=$G_ACCOUNT \
  BRANCH=$BRANCH \
  COMMIT=$COMMIT

WORKDIR /

RUN dnf -y --allowerasing install findutils wget &&\
    dnf clean all
RUN mkdir -pv /root/.local/bin /root/.ghcup/bin
RUN wget "https://raw.githubusercontent.com/${G_ACCOUNT}/guild-operators/${BRANCH}/scripts/cnode-helper-scripts/guild-deploy.sh"
RUN chmod 755 guild-deploy.sh
RUN cat guild-deploy.sh
RUN export SUDO='N' &&\
    export G_ACCOUNT="${G_ACCOUNT}" &&\
    export UPDATE_CHECK='N' &&\
    ./guild-deploy.sh -b "${BRANCH}" -s pblcowx

