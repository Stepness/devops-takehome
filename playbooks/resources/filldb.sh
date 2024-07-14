#! /bin/sh
mongosh <<EOF
use nciadb
db.createCollection("fakeCollection")
db.fakeCollection.insert({ name: "Stefano", data: "FakeData" })
EOF