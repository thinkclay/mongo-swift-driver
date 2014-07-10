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
    
    init(name:String) {
        self.name = name
    }
    
    func find(querySpec:Document) -> Cursor {
        return Cursor()
    }
    
    func find(querySpec:Document, fields:Document) -> Cursor {
        return Cursor()
    }
    
    func find(querySpec:Document, fields:Document, skip:UInt, limit:UInt) -> Cursor {
        return Cursor()
    }
    
    func find(querySpec:Document, fields:Document, skip:UInt, limit:UInt, options:UInt) -> Cursor {
        return Cursor()
    }
    
}