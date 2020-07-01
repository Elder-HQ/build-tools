###################################################################
#                           Build tools                           #
###################################################################
FROM alpine:3.12.0 AS build-stage
#FROM anapsix/alpine-java:8u121b13_jdk_unlimited AS build-stage

RUN apk --update add curl
# Install dependencies required by perf-map-agent build
RUN apk add openjdk8=8.242.08-r2 perf cmake make g++

ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk

# Build honest profiler
RUN wget http://insightfullogic.com/honest-profiler.zip -O /honest-profiler.zip
RUN mkdir /honest-profiler
RUN unzip honest-profiler.zip -d /honest-profiler

# Build perf map agent - convenience scripts for simplifying the use of perf
RUN curl -L https://github.com/jvm-profiling-tools/perf-map-agent/archive/master.zip -o /perf-map-agent.zip
RUN mkdir /perf-map-agent
RUN unzip perf-map-agent.zip -d /tmp
WORKDIR /tmp/perf-map-agent-master/
RUN cmake .
RUN make

RUN cp -R bin out /perf-map-agent

###################################################################
#                    Build final docker image                     #
###################################################################
FROM alpine:3.12.0

RUN apk --no-cache add bash openjdk8=8.242.08-r2

ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk

# Required to install perf
# RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing/' >> /etc/apk/repositories

# Install honest profiler
COPY --from=build-stage /honest-profiler /tools/honest-profiler/

# Install perf map agent scripts
COPY --from=build-stage /perf-map-agent /tools/perf-map-agent/

# Install perf_events and other tools required by perf map agent scripts
RUN apk --no-cache add openjdk8=8.242.08-r2 perf sudo
# RUN apk --no-cache add linux-tools-generic
#  apt-get install -y linux-perf

# Install useful tools like curl and jq
RUN apk --no-cache add curl jq

# Set some sane defaults for users of the image
WORKDIR /root
CMD ["/bin/bash"]
