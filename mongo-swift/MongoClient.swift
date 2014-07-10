//
//  MongoClient.swift
//  mongo-swift
//
//  Created by Luke Lovett on 7/10/14.
//  Copyright (c) 2014 WDEM. All rights reserved.
//

import Foundation

// TODO: use real bson type


class MongoClient {
    var __client:COpaquePointer
    
    init(connectionString:String) {
        var cConnectionString:CString = connectionString.bridgeToObjectiveC().UTF8String
        self.__client = mongoc_client_new(cConnectionString)
    }
    
    func getDatabase(name:String) {
        // TODO
    }
    
    func runCommand(command:String) {
        // TODO: this doesn't actually take a string. It takes a Document.
    }
}