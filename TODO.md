BSON:
-> handle bson_to_C for arbitrary types
-> implement c_to_bson
-> Add missing types and respective classes (BinData, Javascript, minkey, etc)
-> implement "printable" for BSON (toString())
-> Implement `==` for BSON document
-> error handling

CONNECTION:
-> implement findOne()
-> implement count/hint/explain/where
-> Connection/Database should be subscriptable
-> error handling
-> Read preferences
-> WriteConcern
