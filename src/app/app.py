from flask import Flask, request, jsonify
import requests as http_client
from pymongo import MongoClient
import time
import json
from bson import ObjectId, Timestamp

app = Flask(__name__)


class JSONEncoder(json.JSONEncoder):
    def default(self, o):
        if isinstance(o, ObjectId):
            return str(o)
        if isinstance(o, Timestamp):
            return str(o)
        if isinstance(o, bytes):
            return str(o)
        return json.JSONEncoder.default(self, o)


mongo = None
retries = 10
while mongo is None:
    try:
        mongo = MongoClient('localhost', replicaset='satispay-repl')
    except:
        if retries == 0:
            raise Exception("Impossibile to establish DB connection")
        else:
            retries -= 1
            time.sleep(30)


@app.route("/hello")
def hello_world():
    return "Hello, World!"


@app.route("/find", methods=['GET'])
def find():
    db = mongo['default']
    # get the query string as a dict
    find_query_string = request.args.to_dict()
    collection = find_query_string.get('collection', "default")
    if find_query_string.get('collection', None):
        del find_query_string['collection']
    docs = []
    for doc in db[collection].find(find_query_string, {'_id': 0}):
        docs.append(doc)
    return jsonify(docs)


@app.route("/insert", methods=['POST'])
def insert():
    """
    Receives a json like:
        {
            collection: ...
            doc: {...}
        }

    Request the insertion of <doc> into <collection>

    """
    db = mongo['default']
    # get the query string as a dict
    insert_query = request.json
    collection = insert_query.get('collection', "default")
    if insert_query.get('collection', None):
        del insert_query['collection']
    return jsonify(JSONEncoder().encode(db[collection].insert(insert_query['doc'])))


@app.route("/update", methods=['PUT'])
def update():
    """
    Receives a json like:
        {
            collection: ...
            query: { ... }
            doc: {...}
        }

    Updates the docs in <collection> that match <query> with the values specifed in <doc>

    """
    db = mongo['default']
    # get the query string as a dict
    update_query = request.json
    collection = update_query.get('collection', "default")
    if update_query.get('collection', None):
        del update_query['collection']
    return jsonify(JSONEncoder().encode(db[collection].update(update_query['query'], update_query['doc'])))


@app.route("/delete", methods=['POST'])
def delete():
    """
    Receives a json like:
        {
            collection: ...
            query: { ... }
        }

    Deletes the docs in <collection> that match <query>
    """
    db = mongo['default']
    # get the query string as a dict
    delete_query = request.json
    collection = delete_query.get('collection', "default")
    if delete_query.get('collection', None):
        del delete_query['collection']
    return jsonify(JSONEncoder().encode(db[collection].delete_many(delete_query['query']).deleted_count))
