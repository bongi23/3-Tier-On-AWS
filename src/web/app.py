from flask import Flask, request
import requests as http_client
app = Flask(__name__)

APP_SERVICE_URI = "http://0.0.0.0:8080/"


@app.route("/hello")
def hello_world():
    return "Hello, World!"


@app.route("/find", methods=['GET'])
def find():
    # get the query string as a dict
    find_query_string = request.args.to_dict()
    # forward request to app service
    response = http_client.get(APP_SERVICE_URI, params=find_query_string)
    return response.json()


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
    # get the query string as a dict
    json_data = request.get_json()
    # forward request to app service
    response = http_client.post(APP_SERVICE_URI, json=json_data)
    return response.json()


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
    # get data as json
    json_data = request.get_json()
    # forward request to app service
    response = http_client.put(APP_SERVICE_URI, data=json_data)
    return response.json()


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
    # get data as json
    json_data = request.get_json()
    # forward request to app service
    response = http_client.post(APP_SERVICE_URI, data=json_data)
    return response.json()
