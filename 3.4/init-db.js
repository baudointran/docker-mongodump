	
db = db.getSiblingDB('sample')

db.sampleCollection.insertOne({
    firstName: "test",
    lastName: "dummy"
});