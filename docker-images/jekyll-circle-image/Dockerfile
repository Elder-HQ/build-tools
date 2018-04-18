FROM circleci/node:8.9.4-stretch 

ENV LANG C.UTF-8

###################################################################
#                Updating base system and Ruby                    #
###################################################################
RUN \
  sudo apt-get update -y && \
  sudo apt-get update && sudo apt-get install -y --no-install-recommends --no-install-suggests curl bzip2 build-essential libssl-dev libreadline-dev zlib1g-dev && \
  sudo rm -rf /var/lib/apt/lists/* && \
  curl -L https://github.com/sstephenson/ruby-build/archive/v20180329.tar.gz | tar -zxvf - -C /tmp/ && \
  cd /tmp/ruby-build-* && sudo ./install.sh && cd / && \
  sudo ruby-build -v 2.5.1 /usr/local && sudo rm -rfv /tmp/ruby-build-* && \
  sudo gem install bundler --no-rdoc --no-ri && \
  sudo apt-get clean

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
  wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && \
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list && \
  sudo apt-get update && \
  sudo apt-get -y install google-chrome-stable && \
  google-chrome --version

RUN \
  sudo sed -i 's|HERE/chrome"|HERE/chrome" --disable-setuid-sandbox --no-sandbox|g' "/usr/bin/google-chrome"

###################################################################
#              Download Wraith and dependencies                   #
###################################################################

# Install wraith
RUN sudo gem install wraith

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
