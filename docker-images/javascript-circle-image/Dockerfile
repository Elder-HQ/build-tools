FROM node:8.10.0

ENV LANG C.UTF-8

###################################################################
#                 Install Oracle JDK for Java 8                   #
###################################################################
RUN \
  echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list  && \
  echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list  && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 && \
  apt-get update && \
  echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
  DEBIAN_FRONTEND=noninteractive  apt-get install -y --force-yes oracle-java8-installer oracle-java8-set-default && \
  rm -rf /var/cache/oracle-jdk8-installer && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

###################################################################
#              Download Netlify command line client               #
###################################################################

RUN \
  cd /root && \
  mkdir opt && \
  cd opt && \
  wget https://github.com/netlify/netlifyctl/releases/download/v0.3.2/netlifyctl-linux-amd64-0.3.2.tar.gz && \
  tar -xzvf netlifyctl-linux-amd64-0.3.2.tar.gz && \
  rm netlifyctl-linux-amd64-0.3.2.tar.gz

ENV PATH /root/opt:$PATH

###################################################################
#                   Install global build tools                    #
###################################################################
RUN \
  echo "Installing Global Build Tools" && \
  npm install -g gulp-cli@2.0.0

# Make sure to use our own version of yarn so that we can control the version independently
RUN \
  rm -f /usr/local/bin/yarnpkg && \
  rm -f /usr/local/bin/yarn && \
  rm -rf ${HOME}/.yarn && \
  curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 1.5.1

ENV PATH /root/.yarn/bin:$PATH

###################################################################
#                   Install common dependencies                   #
###################################################################
RUN \
  echo "Getting dependencies as of 20180316" && \
  cd $HOME && \
  git clone https://github.com/Elder-HQ/build-tools.git && \
  cd build-tools/javascript-dependencies && \
  yarn install && \
  cd $HOME && \
  rm -rf build-tools

###################################################################
#          Set some sane defaults for users of the image          #
###################################################################
WORKDIR /root
CMD ["/bin/bash"]
