FROM ubuntu:16.04

RUN mkdir -p /swift
WORKDIR /swift

RUN apt-get update; apt-get install -y \
  clang \
  git \
  libicu-dev \
  wget \
  libcurl4-openssl-dev \
  libssl-dev \
  libxml2-dev

RUN wget https://swift.org/builds/swift-4.0-branch/ubuntu1604/swift-4.0-DEVELOPMENT-SNAPSHOT-2017-09-13-a/swift-4.0-DEVELOPMENT-SNAPSHOT-2017-09-13-a-ubuntu16.04.tar.gz
RUN tar xzvf swift-4.0-DEVELOPMENT-SNAPSHOT-2017-09-13-a-ubuntu16.04.tar.gz -C /swift
ENV PATH /swift/swift-4.0-DEVELOPMENT-SNAPSHOT-2017-09-13-a-ubuntu16.04/usr/bin:$PATH

RUN mkdir -p /app
WORKDIR /app

COPY . /app

CMD ["swift", "build"]