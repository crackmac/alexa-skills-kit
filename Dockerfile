# Original source from https://hub.docker.com/_/node/
FROM node:12.18.4-alpine
LABEL maintainer="Martin DSouza <martin@talkapex.com>"
LABEL maintainer="Kevin Duane <crackmac@gmail.com>"

# ASK CLI version
ARG ASKVER=2.16.3

# NPM_CONFIG_PREFIX: See below
# PATH: Required for ask cli location
ENV TZ="GMT" \
  NPM_CONFIG_PREFIX=/home/node/.npm-global \
  PATH="${PATH}:/home/node/.npm-global/bin/:/home/node/.local/bin/"

# Required pre-reqs for ask cli
RUN apk add --update \
  python \
  make \
  bash \
  py-pip \
  zip \
  git

WORKDIR /app
USER node

# /home/node/.ask: For ask CLI configuration file
# /home/node/.ask: Folder to map to for app development
RUN npm install -g ask-cli@$ASKVER && \
  mkdir /home/node/.ask && \
  mkdir /home/node/.aws && \
  mkdir /home/node/app && \
  pip install awscli --upgrade --user 

RUN npm --version && \
  aws --version && \
  ask --version 

# Volumes:
# /home/node/.ask: This is the location of the ask config folder
# /home/node/app: Your development folder
VOLUME ["/home/node/.ask", "/home/node/.aws", "/home/node/app"]

# Enable this if you want the container to permanently run
# CMD ["/bin/bash"]

# Default folder forgit status developers to work in
WORKDIR /home/node/app