//
//  Cursor.swift
//  mongo-swift
//
//  Created by Luke Lovett on 7/10/14.
//  Copyright (c) 2014 WDEM. All rights reserved.
//

import Foundation

enum CursorOptions: UInt {
    case NoOptions = 0,
    Tailable,
    SlaveOK,
    OplogReplay,
    NoTimeout,
    AwaitData,
    Exhaust,
    Partial
}

class Cursor {
    
    var __collection: COpaquePointer
    var skip:UInt
    var limit:UInt
    var options:CursorOptions
    
    init(__collection: COpaquePointer) {
        self.__collection = __collection
        self.skip = 0
        self.limit = 0
        self.options = CursorOptions.NoOptions
    }
    
    func skip(skip: UInt) -> Cursor {
        self.skip += skip
        return self
    }
    
    func limit(limit: UInt) -> Cursor {
        self.limit = limit
        return self
    }
    
    func addOptions(options: CursorOptions) -> Cursor {
        // TODO
        return self
    }
    
}