# Manual Build Process

```
docker container run -it \
--platform linux/amd64 \
-e SDKMAN_DIR=/root/.sdkman \
-e GRAILS_VERSION=1.3.9 \
-p 8080:8080 \
-v ./openboxes-config.properties:/root/.grails/openboxes-config.properties \
-v ./openboxes-setenv.sh:/usr/share/tomcat7/bin/setenv.sh \
-v ./openboxes-run.sh:/root/openboxes-run.sh \
-v ./openboxes:/app \
azul/zulu-openjdk:7u352-7.56.0.11
```

```
docker run -d --name mysql-openboxes \
--platform linux/amd64 \
-e MYSQL_ROOT_PASSWORD=openboxes \
-p 3306:3306 \
mysql:5.7.44
```