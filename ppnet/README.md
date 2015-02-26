## Docker image for ppnet, the Social Network Enabler

This is a Docker image of [ppnet](https://github.com/pixelpark/ppnet).

### Running the Docker image using a shared database server

Once Docker is installed, use the following command to run ppnet and forward the container port 80 to the host port 8000:

```
docker run -d -p 8000:80 fic2/ppnet
```
You can then access the website at [http://localhost:8000](http://localhost:8000)

### Running the Docker image with your own database server

First run a CouchDB server and publish it on port 5984:

```
docker run -d -p 5984:5984 fic2/couchdb
```

Then launch ppnet with:

```
docker run -d -p 8000:80 -e COUCHDB_URL=http://your_host_ip:5984 fic2/ppnet
```
Bear in mind that the CouchDB URL is used from client-side JavaScript code running on user's browsers. The specified IP and port need to be accessible from the user's browsers.

You can try whether this is true beforehand by browsing to http://your_host_ip:5984

### Building the Docker image

```
git clone https://github.com/tai-lab/ppnet.git
cd ppnet
docker build -t my_username/ppnet .
```

