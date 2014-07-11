//
//  WriteConcern.swift
//  mongo-swift
//
//  Created by Luke Lovett on 7/10/14.
//  Copyright (c) 2014 WDEM. All rights reserved.
//

import Foundation

class WriteConcern {
    var w:UInt
    var j:UInt
    var wTimeout:UInt
    var fsync:Bool
    
    init(w:UInt, j:UInt, wTimeout: UInt, fsync: Bool) {
        self.w = w
        self.j = j
        self.wTimeout = wTimeout
        self.fsync = fsync
    }
}