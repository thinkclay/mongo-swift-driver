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
    case BSONObject(Dictionary<String, BSONValue>)

    /*
     * Error conditions
     */
    case BSONInvalid(NSError)
    
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

    var string: String? {
    switch self {
    case .BSONString(let value):
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

    var object: Dictionary<String, BSONValue>? {
    switch self {
    case .BSONObject(let value):
        return value
    default:
        return nil
        }
    }
    
    init(_ rawObject: AnyObject) {
        switch rawObject {
            
        case let value as NSString:
            self = .BSONString(value)
        
        case let value as NSArray:
        var BSONValues = [BSONValue]()
        for el: AnyObject in value {
            /* XXX: el can ever be nil */
            BSONValues.append(BSONValue(el))
        }
        self = .BSONArray(BSONValues)
            
        case let value as NSDictionary:
            var bson_obj = Dictionary<String, BSONValue>()
            for (my_key:AnyObject, my_value:AnyObject) in value {
                if let key = my_key as? NSString {
                    let b_val = BSONValue(my_value)
                    /* XXX: value can ever be nil ? */
                    bson_obj[key] = b_val
                }
            }
        self = .BSONObject(bson_obj)
        
        default:
            self = .BSONInvalid(NSError(domain: "BSONErrorDomain", code: 1001,
                userInfo: [NSLocalizedDescriptionKey:"Invalid BSON type"]))
        }
    }
    
    subscript(index: Int) -> BSONValue {
        get {
            switch self {
            case .BSONArray(let bsonArray) where bsonArray.count > index:
                return bsonArray[index]
            case .BSONInvalid(let error):
                return BSONValue.BSONInvalid(NSError(domain: "BSONErrorDomain", code: 1001,
                    userInfo: [NSLocalizedDescriptionKey:"Bad key path"]))
            default:
                return BSONValue.BSONInvalid(NSError(domain: "BSONErrorDomain", code: 1001,
                    userInfo: [NSLocalizedDescriptionKey:"Bad key path"]))
            }
        }
    }
    
    subscript(key: String) -> BSONValue {
        get {
            switch self {
            case .BSONObject(let bsonDictionary):
                if let value = bsonDictionary[key] {
                    return value
                } else {
                    return BSONValue.BSONInvalid(NSError(domain: "BSONErrorDomain", code: 1001,
                        userInfo: [NSLocalizedDescriptionKey:"Bad key path"]))
                }
            case .BSONInvalid(let error):
                return BSONValue.BSONInvalid(NSError(domain: "BSONErrorDomain", code: 1001,
                    userInfo: [NSLocalizedDescriptionKey:"Bad key path"]))
            default:
                return BSONValue.BSONInvalid(NSError(domain: "BSONErrorDomain", code: 1001,
                    userInfo: [NSLocalizedDescriptionKey:"Bad key path"]))
            }
        }
    }
}