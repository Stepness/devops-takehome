from flask import Flask, jsonify
from pymongo import MongoClient
from bson import json_util
import json

app = Flask(__name__)

MONGO_HOST = '52.178.79.182'
MONGO_PORT = 27017
MONGO_DB = 'myDatabase'
MONGO_COLLECTION = 'myCollection'

client = MongoClient(MONGO_HOST, MONGO_PORT)
db = client[MONGO_DB]
collection = db[MONGO_COLLECTION]

@app.route('/people', methods=['GET'])
def people():
    try:
        data = list(collection.find())
        return json.loads(json_util.dumps(data)), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)
