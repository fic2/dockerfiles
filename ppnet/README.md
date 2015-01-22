## Dockerfile for ppnet, the Social Network Enabler

This directory contains a Dockerfile of [ppnet](https://github.com/pixelpark/ppnet).


### Requirements

* Install [Docker](https://www.docker.com)

### Running the Docker image from the public registry

* (https://registry.hub.docker.com/u/fic2/ppnet/)

Once Docker is installed, run:
```
docker run --name my-social-network -d fic2/ppnet
```
The web server will be listening at http://container-ip
You can find the container-ip by running ```docker inspect my-social-network | grep IPAddress```

You can forward the container port 80 to the host 8000 by running instead:
```
docker run --name my-social-network -d -p 8000:80 fic2/ppnet
```
You can then access the website at http://host-ip:8000

### Building the Docker image

* Use the following command inside the cloned repository:

    ```
	docker build -t 'fic2/ppnet' .
	```

