FROM cypress/browsers:chrome67

ENV LANG C.UTF-8

###################################################################
#                Updating base system and Ruby                    #
###################################################################
RUN \
  apt-get update -y && \
  apt-get update && apt-get install -y --no-install-recommends --no-install-suggests curl bzip2 build-essential libssl-dev libreadline-dev zlib1g-dev && \
  rm -rf /var/lib/apt/lists/* && \
  curl -L https://github.com/sstephenson/ruby-build/archive/v20180329.tar.gz | tar -zxvf - -C /tmp/ && \
  cd /tmp/ruby-build-* && ./install.sh && cd / && \
  ruby-build -v 2.5.1 /usr/local && rm -rfv /tmp/ruby-build-* && \
  gem install bundler --no-rdoc --no-ri && \
  apt-get clean

###################################################################
#              Download Netlify command line client               #
###################################################################
RUN \
  cd && \
  wget https://github.com/netlify/netlifyctl/releases/download/v0.3.3/netlifyctl-linux-amd64-0.3.3.tar.gz && \
  tar -xzvf netlifyctl-linux-amd64-0.3.3.tar.gz && \
  rm netlifyctl-linux-amd64-0.3.3.tar.gz

RUN \
  cd && \
  wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list && \
  apt-get update && \
  apt-get -y install google-chrome-stable && \
  google-chrome --version

RUN \
  sed -i 's|HERE/chrome"|HERE/chrome" --disable-setuid-sandbox --no-sandbox|g' "/usr/bin/google-chrome"

###################################################################
#              Download Wraith and dependencies                   #
###################################################################

# Install wraith
RUN gem install wraith

###################################################################
#                  Force downloading Ruby gems                    #
###################################################################
RUN \
  echo "Getting dependencies as of 20180418" && \
  cd $HOME && \
  git clone https://github.com/Elder-HQ/build-tools.git && \
  cd build-tools/jekyll-dependencies && \
  bundle install && \
  cd $HOME && \
  rm -rf build-tools
