FROM azul/zulu-openjdk:7u352-7.56.0.11

LABEL maintainer="Michael Seaton mseaton@pih.org"

# Environment variables

ENV SDKMAN_DIR /root/.sdkman
ENV GRAILS_VERSION 1.3.9
ENV NODE_VERSION=14.21.3


# Install Base Packages required
RUN apt-get update && apt-get install -y curl zip python2 g++ make gcc build-essential git

# Download node + extract
RUN curl -LO https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz &&\
    tar -xvf node-v${NODE_VERSION}-linux-x64.tar.xz

# Update our PATH to include the node binary
ENV PATH=${PATH}:/node-v${NODE_VERSION}-linux-x64/bin

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
ENV JAVA_HOME /usr/lib/jvm/zulu7-ca-amd64
ENV GRAILS_HOME /root/.sdkman/candidates/grails/current
ENV PATH $GRAILS_HOME/bin:$PATH
# Memory settings were required or else things would fail with OOM errors or stall forever
ENV GRAILS_OPTS -XX:MaxPermSize=8192m -Xmx8192M -XX:-UseSplitVerifier -Xverify:none

# Set the directory that an existing Grails app should be mounted into with a volume
RUN mkdir /app
WORKDIR /app

EXPOSE 8080

CMD ["grails"]