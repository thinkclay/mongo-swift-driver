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
    
    init(name:String) {
        self.name = name
    }
    
    func getCollection(name:String) -> Collection {
        return Collection(name:name)
    }
    
    func runCommand(command:Document) -> Document {
        // TODO: this isn't actually a string
        return Document("")
    }
}