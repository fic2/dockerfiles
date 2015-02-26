## Docker image for POIProxy, by Prodevelop

[POIProxy](https://github.com/Prodevelop/POIProxy) is a proxy service to retrieve POIs (Points Of Interest) from several public services (Nominatim, Mapquest, Cloudmade, Geonames, Panoramio, Ovi, Flickr, Twitter, LastFM, Wikipedia, Youtube, Foursquare, ...)

### Running the Docker image

Once Docker is installed, run:

```
docker run --name my-poiproxy -d -p 8080:8080 fic2/poiproxy
```

After download and launch, you can test the API of your service through the following page:
[http://localhost:8080/poiproxy/public/index.html](http://localhost:8080/poiproxy/public/index.html)

### Building your own version of this Docker image

Prerequisites: git, java, maven and docker

```
git clone https://github.com/tai-lab/POIProxy.git
cd POIProxy
mvn package
docker build -t my_username/poiproxy .
```

