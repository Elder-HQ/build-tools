FROM node:10

###################################################################
#            Install global build and deployment  tools           #
###################################################################
ENV PATH /root/opt:$PATH

RUN \
  echo "Installing Global Build Tools" && \
  npm install -g gulp-cli@2.0.0 && \
  npm install -g firebase-tools

# Make sure to use our own version of yarn so that we can control the version independently
RUN \
  apt-get update && \
  apt-get install -y curl && \
  rm -f /usr/local/bin/yarnpkg && \
  rm -f /usr/local/bin/yarn && \
  rm -rf ${HOME}/.yarn && \
  curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 1.16.0 && \
  apt-get remove -y --purge curl && \
  apt-get autoremove && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ENV PATH /root/.yarn/bin:$PATH

###################################################################
#          Set some sane defaults for users of the image          #
###################################################################
WORKDIR /root
CMD ["/bin/bash"]
