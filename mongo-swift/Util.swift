//
//  Util.swift
//  mongo-swift
//
//  Created by Luke Lovett on 7/10/14.
//  Copyright (c) 2014 WDEM. All rights reserved.
//

import Foundation

func cStringFromNSString(str:String) -> CString {
    return str.bridgeToObjectiveC().UTF8String;
}