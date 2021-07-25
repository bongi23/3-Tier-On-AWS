from flask import Flask, request, jsonify
from pymongo import MongoClient
import time
import json
from bson import ObjectId, Timestamp

app = Flask(__name__)


class JSONEncoder(json.JSONEncoder):
    """
    This is a utility class used to convert some fields of MongoDB objects to str
    """
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
    except Exception as e:
        if retries == 0:
            raise Exception(f"Impossible to establish a connection to the database: {str(e)}")
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
    # iterate of the cursor returned by MongoClient
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
    if not insert_query:
        return jsonify({"errmsg": "No JSON body received"})
    collection = insert_query.get('collection', "default")

    if insert_query.get('collection', None):
        del insert_query['collection']

    if not insert_query.get('doc', None):
        return jsonify({"errmsg":"You should specify a 'doc' field on the input json."})

    obj_id = db[collection].insert(insert_query['doc'])

    if obj_id:
        return jsonify({"success": "The document has been correctly inserted."})
    else:
        return jsonify({"errmsg":"Error while inserting the document!"})



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
    if update_query is None:
        return jsonify({"errmsg":"No JSON data received"})

    collection = update_query.get('collection', "default")

    if update_query.get('collection', None):
        del update_query['collection']

    if not update_query.get('doc', None):
        return jsonify({"errmsg": "You must specify a set of key/values to be updated!"})

    update_res = db[collection].update(update_query.get('query', {}), update_query['doc'])
    if update_res:
        return jsonify({"success": f"{update_res['nModified']} documents have been updated."})
    else:
        return jsonify({"errmsg":"Error while updating the document!"})


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
    if not delete_query:
        return jsonify({"errmsg":"No JSON data received"})

    collection = delete_query.get('collection', "default")
    if delete_query.get('collection', None):
        del delete_query['collection']

    qry_res = db[collection].delete_many(delete_query['query'])

    if qry_res:
        return jsonify({"success":f"{qry_res.deleted_count} documents have been deleted."})

    return jsonify({"errmsg": "Error while deleting documents"})
