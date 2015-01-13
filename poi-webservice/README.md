## poi-webservice Dockerfile

This directory contains a Dockerfile of [poi-webservice](https://github.com/stlemme/poi-webservice).


### Requirements

* Install [Docker](https://www.docker.com)


### Usage

The `poi` endpoint is exposed internally on the port 80.
The webservice can be launch and made accessible on the host's port 8080 with the command:

    docker run -d -p 8080:80 fic2/poi-webservice:latest


### Docker image's creation

* Use the following command inside the cloned repository:

    docker build -t 'fic2/poi-webservice:latest' .
