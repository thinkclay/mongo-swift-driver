//
//  mongo_swiftTests.swift
//  mongo-swiftTests
//
//  Created by Luke Lovett on 7/10/14.
//  Copyright (c) 2014 WDEM. All rights reserved.
//

import XCTest
import MongoSwift

class mongo_swiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func simple_bson() {
        // This is an example of a functional test case.
        let json_val = BSONValue(["10":"234"])
        XCTAssert(json_val["10"].string == "234", "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
