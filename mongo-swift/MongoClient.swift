//
//  MongoClient.swift
//  mongo-swift
//
//  Created by Luke Lovett on 7/10/14.
//  Copyright (c) 2014 WDEM. All rights reserved.
//

import Foundation

// TODO: use real bson type
typealias Document = String


class MongoClient {
    var __client:COpaquePointer
    
    init(connectionString:String) {
        var cConnectionString:CString = connectionString.bridgeToObjectiveC().UTF8String
        self.__client = mongoc_client_new(cConnectionString)
    }
    
    func getDatabase(name:String) -> Database {
        return Database(
            name:name,
            __database:mongoc_client_get_database(self.__client, cStringFromNSString(name)))
    }
}