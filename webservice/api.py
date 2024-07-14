from flask import Flask, jsonify
from pymongo import MongoClient
from bson import json_util
import json
import configparser

app = Flask(__name__)

config = configparser.RawConfigParser()   
config.read("/opt/app/config")

MONGO_HOST = config.get("Database", 'DBSERVER_IP')
MONGO_PORT = 27017
MONGO_DB = 'nciadb'
MONGO_COLLECTION = 'fakeCollection'

client = MongoClient(MONGO_HOST, MONGO_PORT)
db = client[MONGO_DB]
collection = db[MONGO_COLLECTION]

@app.route('/fakedata', methods=['GET'])
def people():
    try:
        data = list(collection.find())
        return json.loads(json_util.dumps(data)), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
