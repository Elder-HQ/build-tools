FROM ubuntu:16.04

###################################################################
#         Basic sane Ubuntu configuration for development         #
###################################################################
RUN \
  apt-get update && \
  apt-get install -y software-properties-common python-software-properties git && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*
  
###################################################################
#                 Install Oracle JDK for Java 8                   #
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

###################################################################
#           Install GCloud SDK and Kubernetes client              #
###################################################################
RUN \
  cd $HOME && \
  wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-147.0.0-linux-x86_64.tar.gz && \
  tar xvf google-cloud-sdk-147.0.0-linux-x86_64.tar.gz && \
  rm google-cloud-sdk-147.0.0-linux-x86_64.tar.gz && \
  ./google-cloud-sdk/install.sh && \
  ./google-cloud-sdk/bin/gcloud components install kubectl

###################################################################
# Force downloading Gradle binaries and common Elder dependencies #
###################################################################
RUN \
  echo "Getting dependencies as of 20170318" && \
  cd $HOME && \
  mkdir .gradle && echo "org.gradle.daemon=false" > .gradle/gradle.properties && \
  git clone https://github.com/Elder-HQ/build-tools.git && \
  cd build-tools/java-dependencies && \
  ./gradlew downloadDependencies && \
  cd $HOME && \
  rm -rf build-tools

###################################################################
#          Set some sane defaults for users of the image          #
###################################################################
WORKDIR /root
CMD ["/bin/bash"]
