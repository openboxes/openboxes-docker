FROM openjdk:7-jdk

MAINTAINER Michael Seaton <mseaton@pih.org>

# Environment variables

ENV GRAILS_VERSION 1.3.9

# Install Base Packages required

RUN apt-get update && apt-get install -y \
    unzip \
    zip \
    curl \
    wget \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install node 

RUN apt-get install -y curl \
    && curl -sL https://deb.nodesource.com/setup_9.x | bash - \
    && apt-get install -y nodejs \
    && curl -L https://www.npmjs.com/install.sh | sh

# Install Grails and Set Path
ENV SDKMAN_DIR /usr/local/sdkman
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

RUN curl -s get.sdkman.io | bash

RUN set -x \
    && echo "sdkman_auto_answer=true" > $SDKMAN_DIR/etc/config \
    && echo "sdkman_auto_selfupdate=false" >> $SDKMAN_DIR/etc/config \
    && echo "sdkman_insecure_ssl=false" >> $SDKMAN_DIR/etc/config

RUN bash -c "source $SDKMAN_DIR/bin/sdkman-init.sh && sdk install grails $GRAILS_VERSION"

ENV GRAILS_HOME /usr/local/sdkman/candidates/grails/current
ENV PATH $GRAILS_HOME/bin:$PATH

# Set the directory that an existing Grails app should be mounted into with a volume
RUN mkdir /app
WORKDIR /app

EXPOSE 8080

CMD ["grails"]