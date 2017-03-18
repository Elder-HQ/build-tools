FROM ubuntu:16.04

###################################################################
#         Basic sane Ubuntu configuration for development         #
###################################################################
RUN \
  apt-get update && \
  apt-get install -y software-properties-common git && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*
  
###################################################################
# Force downloading Gradle binaries and common Elder dependencies #
###################################################################



###################################################################
#                        JDK for Java 8                           #
###################################################################
RUN \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && \
  echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections  && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y oracle-java8-installer && \
  rm -rf /var/cache/oracle-jdk8-installer && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

#########################################
# 
CMD ["/bin/bash"]
