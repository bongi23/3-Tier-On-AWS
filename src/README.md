# Toy application
In this folder you can find the source code of a toy application that leverages the three layer infrastructure deployed.
The application developed allows to execute simple operation on the db, like:
- find
- insert
- update
- delete
and exposes a simple RESTful interface.

## Web
The web layer is the entrypoint for the application. Its duty is to forward request to the application layer and return
a response to the user. It is a simple Flask app that exposes the follwing endpoints:
- */find*: asks the application layer to query the DB to find a certain document. The only allowed method is GET. It is
possible to specify the parameters for the query via *query string*. E.g.: `/find?collection=foo&key1=bar&name=pippo` it
is a request to query the `foo` collection and search for a document with `{key1: bar, name: pippo}` among its attributes.
- */insert*: asks the application layer to insert a certain document into the DB. The only allowed method is POST. The user
should send a JSON body with the following structure: 
``` 
{
    "doc": {...}, // mandatory, the doc to be inserted
    "collection": ... // optional, defaults to "default". The collection where the document should be inserted
} 
```   
- */update*: asks the application layer to update all the documents that match a certain query. The only allowed method is
PUT. The user should send a JSON body with the following structure: 
```
{
    "doc": {...}, // mandatory, the key-value pairs to be updated in the documents that match the query
    "query": {...} // optional, if not specified then all the documents are matched
    "collection": ... // optional, defaults to "default". The collection where the documents should be updated
}
```
- */delete*: asks the application layer to delete all the documents that match a certain query. The only allowed method is
POST. The user should send a JSON body with the following structure: 
```
{
    "query": {...} // mandatory, the documents matched by the query will be deleted
    "collection": ... // optional, defaults to "default". The collection where the documents should be updated
}
```

## App
The application layer can be contacted from the web layer or from localhost. It's duty is to query the MongoDB to satisfy the
request from the web layer. It exposes the same set of endpoints as the web layer.

# DB
The database is a mongo DB deployed as a 3 member replica-set. A replica-set is a fault tolerant and high available deployment
strategy for a database. The script `initRS.py` is executed in one random host during the configuration phase. It initiates
the replica-set.