//
//  Database.swift
//  mongo-swift
//
//  Created by Luke Lovett on 7/10/14.
//  Copyright (c) 2014 WDEM. All rights reserved.
//

import Foundation

class Database {
    var name:String
    var __database:COpaquePointer
    
    init(name:String, __database:COpaquePointer) {
        self.name = name
        self.__database = __database
    }
    
    func getCollection(name: String) -> Collection {
        var collection = mongoc_database_get_collection(
            self.__database,
            cStringFromNSString(name))
        return Collection(name: name, __collection: collection)
    }
    
    func runCommand(command: Document) -> Document {
        // Just do isMaster for now
        var commandSpec:UnsafePointer<bson_t> = bson_new()
        bson_append_int32(commandSpec, "isMaster", 8, 1)
        
        var commandResponse:UnsafePointer<bson_t> = bson_new()
        var commandOK = mongoc_database_command_simple(
            self.__database,
            commandSpec,
            nil,
            commandResponse,
            nil)
        
        return "hi"
    }
}