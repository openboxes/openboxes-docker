# openboxes-docker

This project contains the relevant files to run OpenBoxes using Docker.  It utilizes docker-compose, which enables connecting several independent
dockerized services together (in this case MySQL and Tomcat), and maintaining configuration for these within a docker-compose.yml file.

If you haven't already done do, you will need to [Install Docker](https://docs.docker.com/) and [Install Docker Compose](https://docs.docker.com/compose/)

### Pre-requisite:

```
git clone https://github.com/openboxes/openboxes-docker.git
wget https://github.com/openboxes/openboxes/releases/download/v0.8.6/openboxes.war #or your desired version
```

### Step 1:  Adjust the include configuration files as needed

```
cp openboxes-config.properties.sample openboxes-config.properties
```

Although this docker-compose project should work without modification, there may be occasions when you would like more control over the
way it operates, given your particular machine configuration.  Most of the included files should be considered defaults that can be changed.  Some common examples:

**The location of openboxes war** - This is assumed to be in the directory above the contents of this clone, with the name openboxes.war.
You can see this in the docker-compose file, which attempts to mount a volume from "../openboxes.war" on your host into the tomcat container, which is
where the container assumes that the project is located.

**The Tomcat port** - Default is 8080.  Changing this requires editing the "tomcat" service settings in docker-compose.yml 
and the grails.serverUrl in openboxes-config.properties

**The MySQL database name, port, username, or password** - Changing these requires editing the "db" service settings in docker-compose.yml 
and the dataSource.url, dataSource.username, and/or dataSource.password in openboxes-config.properties

**The MySQL persistent storage path** - This defaults to mysql/ under the clone directory. If it doesn't exist, it will be created when you up the compose. This directory holds the data for the system, so that it will survive if the containers are removed or restart.

**The MySQL root password** - Edit the "db" service settings in docker-compose.yml 

**The MySQL configuration** - Edit the included openboxes-mysql.conf file

### Step 2:  Attempt to start up the service

This should be as simple as

`docker-compose up`

This should successfully start up the application.  If any errors occur, these will generally be configuration related.  Fix and repeat this step.

Ctrl-C from the window in which you brought the containers up is sufficient to later stop those services.  You can also stop them explicitly from another
terminal window, by running:

`docker-compose down -v`

When you're satisfied that things seem to be running to your liking, you can up the compose in the background with `docker-compose up -d`. Managing a production docker setup is a bit outside the scope of this document.

### Working with the running containers

Some useful commands that are helpful to work with these containers while they are running:

**Open up a bash shell for working within the tomcat container**: 

`docker-compose exec tomcat bash`

**Connect to MySQL to run some queries**:

`docker-compose exec db mysql -u openboxes -p openboxes`

**Tail the log file of a particular container**

`docker-compose logs -f tomcat`

### Other considerations

If you're going to use this for production data, you should probably have monitoring and the ability to automatically restart containers if needed. You should probably also back up the mysql/ directory and any config files you've modified.

### Bug reports and feature requests

If you encounter a problem with the docker configuration files, or want to suggest an improvement to them, please open an issue here. Pull requests welcome! For issues with the OpenBoxes application, please see the documentation and bug tracker at the project's official github: https://github.com/openboxes/openboxes.
