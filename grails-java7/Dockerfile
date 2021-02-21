FROM openjdk:7-jdk

MAINTAINER Michael Seaton <mseaton@pih.org>

# Environment variables

ENV SDKMAN_DIR /root/.sdkman
ENV GRAILS_VERSION 1.3.9

# Install Base Packages required and Node

RUN apt-get update && apt-get install -y curl zip python g++ make gcc build-essential \
    && curl -sL https://deb.nodesource.com/setup_13.x | bash - \
    && apt-get install -y nodejs \
    && curl -L https://www.npmjs.com/install.sh | sh

# Install Grails and Set Path
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN curl -s "https://get.sdkman.io" | bash
RUN chmod a+x "$SDKMAN_DIR/bin/sdkman-init.sh"


# change timeout and max time based on your liking and internet speed
RUN set -x \
    && echo "sdkman_auto_answer=true" > $SDKMAN_DIR/etc/config \
    && echo "sdkman_auto_selfupdate=false" >> $SDKMAN_DIR/etc/config \
    && echo "sdkman_curl_connect_timeout=20" >> $SDKMAN_DIR/etc/config \
    && echo "sdkman_curl_max_time=0" >> $SDKMAN_DIR/etc/config \
    && echo "sdkman_insecure_ssl=false" >> $SDKMAN_DIR/etc/config

WORKDIR $SDKMAN_DIR
RUN [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh" && exec "$@"

RUN source /root/.bashrc

# install and set grails version
RUN bash -c "source $SDKMAN_DIR/bin/sdkman-init.sh && sdk install grails $GRAILS_VERSION"
RUN bash -c "source $SDKMAN_DIR/bin/sdkman-init.sh && sdk default grails $GRAILS_VERSION"

# set envs
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV GRAILS_HOME /root/.sdkman/candidates/grails/current
ENV PATH $GRAILS_HOME/bin:$PATH
ENV GRAILS_OPTS -XX:-UseSplitVerifier -Xverify:none

# Set the directory that an existing Grails app should be mounted into with a volume
RUN mkdir /app
WORKDIR /app

EXPOSE 8080

CMD ["grails"]
