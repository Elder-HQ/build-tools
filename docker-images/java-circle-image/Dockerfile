FROM adoptopenjdk:8u262-b10-jdk-openj9-0.21.0

###################################################################
#         Basic sane Ubuntu configuration for development         #
###################################################################
RUN \
  apt-get update && \
  apt-get install -y software-properties-common git docker.io && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

###################################################################
#             Install useful tools like curl and jq               #
###################################################################
RUN \
  apt-get update && \
  apt-get install -y curl jq && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

###################################################################
#                        Install Git LFS                          #
###################################################################
RUN \
  apt-get update && \
  (curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash) && \
  apt-get install -y git-lfs=2.10.0 && \
  git lfs install && \
  apt-get autoremove && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

###################################################################
#           Install GCloud SDK and Kubernetes client              #
###################################################################
# Find the latest version here: https://cloud.google.com/sdk/docs/downloads-versioned-archives
RUN \
  cd $HOME && \
  curl -o google-cloud-sdk.tar.gz "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-277.0.0-linux-x86_64.tar.gz" && \
  tar xf google-cloud-sdk.tar.gz && \
  rm google-cloud-sdk.tar.gz && \
  ./google-cloud-sdk/install.sh && \
  ./google-cloud-sdk/bin/gcloud components install kubectl

###################################################################
# Force downloading Gradle binaries and common Elder dependencies #
###################################################################
RUN \
  echo "Getting dependencies as of 2020-01-23" && \
  cd $HOME && \
  mkdir .gradle && echo "org.gradle.daemon=false" > .gradle/gradle.properties && \
  git clone https://github.com/Elder-HQ/build-tools.git && \
  cd build-tools/java-dependencies && \
  ./gradlew compileJava && \
  cd $HOME && \
  rm -rf build-tools

###################################################################
# Set the locale to en_GB.UTF-8                                   #
###################################################################
RUN apt-get update && \
  apt-get install -y locales && \
  locale-gen en_GB.UTF-8 && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:en
ENV LC_ALL en_GB.UTF-8

###################################################################
#          Set some sane defaults for users of the image          #
###################################################################
WORKDIR /root
CMD ["/bin/bash"]
