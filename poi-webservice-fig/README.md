## poi-webservice & Fig

This directory contains a `fig.yml` file for [poi-webservice](https://github.com/stlemme/poi-webservice).

**Warning: this is not a working example.**
**Currently the `poi-webservice` code source is only able to connect to a mongodb instance running at the default location (`localhost:27017`).**


### Requirements

* Install [Docker](https://www.docker.com)
* Install [Fig](http://www.fig.sh)


### Usage

The `poi` endpoint is exposed on the port 80.
The webservice can be started with the command:

    fig up


### Docker image's creation

* Use the following command inside the cloned repository:

    ```
	docker build -t 'fic2/poi-webservice:latest' .
	```


### Manual start

Steps to manually start the Docker containers:

* `docker run -d --name="db" mongo:2.6`
* `docker run -d -p "80:80" --name="web" --link="db:db" fic2/poi-webservice:latest`
