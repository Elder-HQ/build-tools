FROM python:3.8.2-alpine3.11
MAINTAINER Elder Developers "developers@elder.org>"

# Installing base development tools
RUN apk add build-base

# Installing native dependencies
RUN \
  apk add libffi-dev && \
  apk add openssl-dev

# Installing required Python packages

RUN \
  pip install --no-cache-dir simple_salesforce && \
  pip install --no-cache-dir apscheduler && \
  pip install --no-cache-dir cython && \
  pip install --no-cache-dir datetime && \
  pip install --no-cache-dir importlib && \
  pip install --no-cache-dir numpy && \
  pip install --no-cache-dir pandas && \
  pip install --no-cache-dir sqlalchemy && \
  pip install --no-cache-dir pymysql && \
  pip install --no-cache-dir pygsheets
