FROM google/debian:wheezy
RUN apt-get update
RUN apt-get -y install curl
RUN apt-get install -y openjdk-7-jre
RUN apt-get install -y tomcat7
RUN apt-get install -y mysql-server
RUN curl -L https://github.com/openboxes/openboxes/releases/download/v0.7.4/openboxes.war -o /var/lib/tomcat7/webapps/openboxes.war
ADD openboxes-config.properties /usr/share/tomcat7/.grails/openboxes-config.properties
ADD run.sh /root/run.sh
RUN chmod +x /root/run.sh
EXPOSE 8080
CMD ["/root/run.sh"]
