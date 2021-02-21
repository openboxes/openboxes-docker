#!/bin/bash

# grails doesn't run without it for some reason
export GRAILS_OPTS="-XX:-UseSplitVerifier -Xverify:none"

if [ ! -f /app/web-app/WEB-INF/applicationContext.xml ]; then
   echo "Forcing grails upgrade"
   grails upgrade --force --stacktrace
fi


npm cache clean --force
npm cache verify
npm i -g npm@6.14.6
npm config set engine-strict true
# npm update

# some dependencies don't get resolved on thier own
npm i --no-package-lock --legacy-peer-deps --force --verbose --stacktrace
grails run-app --stacktrace

# if you want to compile enable this and stop grails run-app
# grails -Dgrails.env=staging war
