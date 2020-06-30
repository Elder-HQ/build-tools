###################################################################
#                           Build tools                           #
###################################################################
FROM anapsix/alpine-java:8u121b13_jdk_unlimited AS build-stage

RUN apk --no-cache add curl

# Build honest profiler
RUN wget http://insightfullogic.com/honest-profiler.zip -O /honest-profiler.zip
RUN mkdir /honest-profiler
RUN unzip honest-profiler.zip -d /honest-profiler

# Build perf map agent - convenience scripts for simplifying the use of perf
# RUN curl -L https://github.com/jvm-profiling-tools/perf-map-agent/archive/master.zip -o /perf-map-agent.zip
# RUN mkdir /perf-map-agent
# RUN unzip perf-map-agent.zip -d /perf-map-agent

###################################################################
#                    Build final docker image                     #
###################################################################
FROM anapsix/alpine-java:8u121b13_jdk_unlimited

# Required to install perf
# RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing/' >> /etc/apk/repositories

# Install honest profiler
COPY --from=build-stage /honest-profiler /honest-profiler/

# Install perf map agent scripts
# COPY --from=build-stage /perf-map-agent /perf-map-agent/

# Install perf_events
# RUN apk --no-cache add perf
# RUN apk --no-cache add linux-tools-generic
#  apt-get install -y linux-perf

# Install useful tools like curl and jq
RUN apk --no-cache add curl jq

# Set some sane defaults for users of the image
WORKDIR /root
CMD ["/bin/bash"]
