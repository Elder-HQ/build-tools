FROM ruby:2.3.7-slim-stretch

ENV LANG C.UTF-8

###################################################################
#                    Updating base system                         #
###################################################################
RUN \
  apt-get update -y && \
  apt-get upgrade -y && \
  apt-get install -y gnupg && \
  apt-get clean

###################################################################
#                 Install Oracle JDK for Java 8                   #
###################################################################
RUN \
  echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list && \
  echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list && \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 && \
  apt-get update && \
  echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes oracle-java8-installer oracle-java8-set-default && \
  rm -rf /var/cache/oracle-jdk8-installer && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

###################################################################
#                 Installing basic development tools              #
###################################################################
RUN \
  apt-get update -y && \
  apt-get install -y git build-essential curl && \
  apt-get clean

###################################################################
#              Download Netlify command line client               #
###################################################################
RUN \
  wget https://github.com/netlify/netlifyctl/releases/download/v0.3.3/netlifyctl-linux-amd64-0.3.3.tar.gz && \
  tar -xzvf netlifyctl-linux-amd64-0.3.3.tar.gz && \
  rm netlifyctl-linux-amd64-0.3.3.tar.gz

###################################################################
#              Download Wraith and dependencies                   #
###################################################################

# Install all apt and Ubuntu dependencies required, including fonts
RUN \
  echo "deb http://ftp.us.debian.org/debian jessie main contrib non-free" | tee -a /etc/apt/sources.list && \
  echo "deb http://security.debian.org/ jessie/updates contrib non-free" | tee -a /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y imagemagick && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Install node and all node dependencies
RUN \
  curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
  apt-get install -y nodejs

# Install node dependencies
RUN \
  npm install chromedriver --chromedriver_cdnurl=https://npm.taobao.org/mirrors/chromedriver && \
  npm install -g selenium-webdriver

# Install wraith
RUN \
  gem install wraith

###################################################################
#                  Force downloading Ruby gems                    #
###################################################################
RUN \
  echo "Getting dependencies as of 20180418" && \
  cd $HOME && \
  git clone https://github.com/Elder-HQ/build-tools.git && \
  cd build-tools/jekyll-dependencies && \
  gem install bundler && \
  bundle install && \
  cd $HOME && \
  rm -rf build-tools

###################################################################
#          Set some sane defaults for users of the image          #
###################################################################
WORKDIR /root
CMD ["/bin/bash"]
