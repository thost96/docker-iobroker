# docker-iobroker
Docker image for ioBroker (http://iobroker.net) based on node:12-slim.

This project creates a Docker image for running ioBroker as a Docker Container. 

## Docker RUN



## Docker-Compose 



## Changelog

### 1.5.0 (21.06.2020)
* (thost96) - changed changelog to global version
* (thost96) - removed deepsource from repo
* (thost96) - added github actions for node-12
* (thost96) - improved Dockerfile for github actions

### 1.4 (15.06.2020)
* (thost96) - fixed installer version and dependencies 
* (thost96) - added healthcheck using admin.0 adapter

### 1.3 (13.03.2020)
* (thost96) - Removed iobroker_startup.sh and iobroker_backup.sh from scripts 
* (thost96) - removed logfile from iobroker_restart.sh

### 1.2 (21.02.2020)
* (thost96) - Added iputils-ping to packages for iobroker.ping
* (thost96) - added more scripts into image and merged startup script into Dockerfile

### 1.1 (02.02.2020)
* (thost96) - Modified startup scripts 
* (thost96) - removed unused scripts 
* (thost96) - linked logfile to stdout for docker logs

### 1.0 (01.02.2020)
* (thost96) - Initial Edit and Release
