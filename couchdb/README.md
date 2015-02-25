## CouchDB Docker image

This CouchDB Docker image is based on klaemo/couchdb

It adds a configuration file enabling CORS, which is required e.g. by PouchDB (used by ppnet)

### Run 

```
docker run -d -p 5984:5984 fic2/couchdb
```

### Test

```
curl http://localhost:5984
```

