//
//  Document.swift
//  mongo-swift
//
//  Created by Davide Italiano on 7/10/14.
//  Copyright (c) 2014 WDEM. All rights reserved.
//

import Foundation

typealias Document = BSONValue

enum BSONValue {

    /*
     * Basic types
     */
    case BSONNumber(NSNumber)
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
    
    var number: NSNumber? {
    switch self {
    case .BSONNumber(let value):
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
            
        case let value as NSNumber:
            self = .BSONNumber(value)

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
    
    func toCBSON() -> UnsafePointer<bson_t>? {
        // Short on time... only doing Dictionary
        var base:UnsafePointer<bson_t> = bson_new()
        if let hash = self.object {
            for (key, value) in hash {
                let cKeyName:CString = cStringFromNSString(key)
                let cKeyLen:Int32 = countElements(key).bridgeToObjectiveC().intValue
                
                // Only doing strings and numbers
                switch value {

                case .BSONNumber(let x):
                    bson_append_int64(base, cKeyName, cKeyLen, x.longLongValue)

                case .BSONString(let x):
                    let utf8Str = cStringFromNSString(value.string!)
                    let utf8Len = countElements(value.string!).bridgeToObjectiveC().intValue
                    bson_append_utf8(base, cKeyName, cKeyLen, utf8Str, utf8Len)

                default:
                    return nil
                }
            }
            return base
        }
        return nil
    }
}