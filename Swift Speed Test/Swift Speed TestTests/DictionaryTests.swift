//
//  DictionaryTests.swift
//  Swift Speed Test
//
//  Created by Piotr Sochalewski on 03.03.2016.
//  Copyright © 2016 Droids On Roids. All rights reserved.
//

import XCTest

class DictionaryTests: XCTestCase {
    
    let repeatCount = 1_000_000
    var dictionary = [Int: Int]()
    
    func dictionaryWithElements() -> [Int: Int] {
        var dictionary = [Int: Int]()
        for i in 0..<repeatCount {
            dictionary[i] = i
        }
        
        return dictionary
    }

    override func setUp() {
        super.setUp()
        dictionary = dictionaryWithElements()
    }

    func testAdd() {
        measureBlock { 
            _ = self.dictionaryWithElements()
        }
    }
    
    func testAccess() {
        var integer: Int?
        
        measureBlock { 
            for i in 0..<self.repeatCount {
                integer = self.dictionary[i]
            }
        }
        
        print(integer)
    }
    
    func testRemove() {
        measureBlock {
            for i in 0..<self.repeatCount {
                self.dictionary.removeValueForKey(i)
            }
        }
    }
    
    func testFastEnum() {
        var keyPlaceholder = Int()
        var valuePlaceholder = Int()

        measureBlock { 
            for (key, value) in self.dictionary {
                valuePlaceholder = value
                keyPlaceholder = key
            }
        }
        
        print(valuePlaceholder)
        print(keyPlaceholder)
    }
    
}