//
//  Document.swift
//  mongo-swift
//
//  Created by Davide Italiano on 7/10/14.
//  Copyright (c) 2014 WDEM. All rights reserved.
//

import Foundation

enum BSONValue {

    /*
     * Basic types
     */
    case BSONByte(UInt8)
    case BSONInt32(UInt32)
    case BSONInt64(UInt64)
    case BSONDouble(Double)
    case BSONString(String)
    
    /*
     * Non-terminals.
     */
    case BSONArray(Array<BSONValue>)
    case BSONOBject(Dictionary<String, BSONValue>)

    /*
     * XXX: Add the missing crap
     */
    
    var byte: UInt8? {
    switch self {
    case .BSONByte(let value):
        return value
    default:
        return nil
        }
    }
    
    var int32: UInt32? {
    switch self {
    case .BSONInt32(let value):
        return value
    default:
        return nil
        }
    }
    
    var int64: UInt64? {
    switch self {
    case .BSONInt64(let value):
        return value
    default:
        return nil
        }
    }

    /* XXX: add missing double/string */
    
    var array: Array<BSONValue>? {
    switch self {
    case .BSONArray(let value):
        return value
    default:
        return nil
        }
    }
    
    init (_ rawObject: AnyObject) {
        switch rawObject {
        case let value as NSArray:
        var BSONValues = [BSONValue]()
        for el: AnyObject in value {
            let b_val = BSONValue(el)
            if b_val {
                bsonvalues.append(b_val)
            }
        }
        self = .BSONArray(BSonValues)
        }
    }
}