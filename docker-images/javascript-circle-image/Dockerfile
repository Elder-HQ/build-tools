FROM ubuntu:16.04

###################################################################
#         Basic sane Ubuntu configuration for development         #
###################################################################
RUN \
  apt-get update && \
  apt-get install -y software-properties-common python-software-properties git gzip bzip2 && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

###################################################################
#                        Install Git LFS                          #
###################################################################
RUN \
  apt-get update && \
  apt-get install -y curl && \
  (curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash) && \
  apt-get install -y git-lfs && \
  git lfs install && \
  apt-get remove -y --purge curl && \
  apt-get autoremove && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

###################################################################
#                 Install Oracle JDK for Java 8                   #
###################################################################
RUN \
  add-apt-repository -y ppa:openjdk-r/ppa && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-8-jdk && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

###################################################################
#                         Install Node                            #
###################################################################
RUN \
  apt-get update && \
  apt-get install -y curl && \
  curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh && \
  bash nodesource_setup.sh && \
  apt-get install -y nodejs && \
  apt-get remove -y --purge curl && \
  apt-get autoremove && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

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
#                   Install common dependencies                   #
###################################################################
RUN \
  echo "Getting dependencies as of 20191111" && \
  apt-get update && \
  apt-get install -y build-essential && \
  cd $HOME && \
  git clone https://github.com/Elder-HQ/build-tools.git && \
  cd build-tools/javascript-dependencies && \
  yarn install --pure-lockfile && \
  cd $HOME && \
  rm -rf build-tools && \
  apt-get remove -y --purge build-essential && \
  apt-get autoremove -y && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

###################################################################
#          Set some sane defaults for users of the image          #
###################################################################
WORKDIR /root
CMD ["/bin/bash"]
