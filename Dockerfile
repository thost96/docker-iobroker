ARG BASEIMAGE=node:12-slim
# hadolint ignore=DL3006
FROM ${BASEIMAGE}

LABEL maintainer="info@thorstenreichelt.de"

ARG LOCALES_VERSION="2.31-0ubuntu9" 
ARG TZDATA_VERSION="2019c-3ubuntu1" 
ARG NODE_GYP_VERSION="7.0.0"
ARG DEBIAN_FRONTEND=noninteractive

# hadolint ignore=DL3008
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    curl \
    locales \ 
    tzdata \ 
    ca-certificates \
    sudo \
    && sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen \
    && \dpkg-reconfigure --frontend=noninteractive locales \
    && \update-locale LANG=de_DE.UTF-8 \
    && cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
    && apt-get autoremove -y \    
    && rm -rf /var/lib/apt/lists/*

WORKDIR /

RUN npm install node-gyp@${NODE_GYP_VERSION} -g
# hadolint ignore=DL4006
RUN apt-get update -qq \
    && curl -sL https://raw.githubusercontent.com/ioBroker/ioBroker/ebe41b9/installer.sh | bash - \
    && iobroker repo set latest \
    && rm -rf /var/lib/apt/lists/*

# hadolint ignore=DL4006
RUN echo 'iobroker ALL=(ALL) NOPASSWD: ALL' | EDITOR='tee -a' visudo \
    && echo "iobroker:iobroker" | chpasswd \
    && adduser iobroker sudo

ENV DEBIAN_FRONTEND="teletype" \
    LANG="de_DE.UTF-8" \
    TZ="Europe/Berlin" 

USER iobroker
EXPOSE 8081/tcp
VOLUME /opt/iobroker 
CMD ["node", "/opt/iobroker/node_modules/iobroker.js-controller/controller.js"]
HEALTHCHECK --interval=60s --timeout=10s --start-period=60s --retries=3 CMD ["curl -f http://localhost:8081/ || exit 1"]
