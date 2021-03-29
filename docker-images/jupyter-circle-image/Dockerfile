FROM circleci/python:3.9.2
ENV LANG C.UTF-8

# We need git-lfs which isn't installed by default
RUN \
  sudo apt-get install git-lfs && \
  git lfs install

# Pre-install our expected dependencies (and Jupyter itself) to make
# things faster when we use this on Circle - we can still install other
# dependencies specified in the project, but these come pre-cached.
ADD requirements.txt /tmp
RUN pip install -r /tmp/requirements.txt
