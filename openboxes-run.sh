#!/bin/bash

if [ ! -f /app/web-app/WEB-INF/applicationContext.xml ]; then
   echo "Forcing grails upgrade"
   grails upgrade --force
fi

npm i
grails run-app
