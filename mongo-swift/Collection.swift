//
//  Collection.swift
//  mongo-swift
//
//  Created by Luke Lovett on 7/10/14.
//  Copyright (c) 2014 WDEM. All rights reserved.
//

import Foundation

class Collection {
    var name:String
    var __collection:COpaquePointer
    
    init(name:String, __collection:COpaquePointer) {
        self.name = name
        self.__collection = __collection
    }
    
    func find() -> Cursor {
        var __cursor:COpaquePointer = mongoc_collection_find(
            self.__collection,  // mongoc_collection_t*
            MONGOC_QUERY_NONE,  // mongoc_query_flags_t
            0,                  // uint32_t
            0,                  // uint32_t
            0,                  // uint32_t
            nil,                // const bson_t*
            nil,                // const bson_t*
            nil)                // const mongoc_read_prefs_t*
        return Cursor(__collection: self.__collection)
    }
//    
//    func find(querySpec:Document) -> Cursor {
//        return Cursor()
//    }
//    
//    func find(querySpec:Document, fields:Document) -> Cursor {
//        return Cursor()
//    }
    
    func insert(document: BSONValue) {
        let c_bson_doc = document.toCBSON()
        mongoc_collection_insert(self.__collection, MONGOC_INSERT_NONE, c_bson_doc!, nil, nil)
    }
    
    func insert(document: Document, writeConcern: WriteConcern) {
        // TODO
    }
    
    func update(querySpec: Document, updateSpec: Document) {
        // TODO
    }
    
    func update(querySpec: Document, updateSpec: Document, upsert: Bool) {
        // TODO
    }
    
    func update(querySpec: Document, updateSpec: Document, upsert: Bool, justOne: Bool) {
        // TODO
    }
    
    func update(querySpec: Document, updateSpec: Document, upsert: Bool, justOne: Bool, writeConcern: WriteConcern) {
        // TODO
    }
    
}