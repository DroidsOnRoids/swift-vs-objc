//
//  DictionaryTests.m
//  ObjC Speed Test
//
//  Created by Piotr Sochalewski on 03.03.2016.
//  Copyright © 2016 Droids On Roids. All rights reserved.
//

// Framework
@import XCTest;

@interface DictionaryTests: XCTestCase

@property (strong, nonatomic) NSMutableDictionary *dictionary;
@property (assign, nonatomic, readonly) NSInteger repeatCount;

@end

@implementation DictionaryTests

- (NSInteger)repeatCount {
    return 1000000; // one million
}

- (NSMutableDictionary *)dictionaryWithElements {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    for (NSInteger i = 0; i < self.repeatCount; i++) {
        dictionary[@(i)] = @(i);
    }
    
    return dictionary;
}

- (void)setUp {
    [super setUp];
    self.dictionary = [self dictionaryWithElements];
}

- (void)testAdd {
    [self measureBlock:^{
        [self dictionaryWithElements];
    }];
}

- (void)testAccess {
    __block NSMutableString *string;

    [self measureBlock:^{
        for (NSInteger i = 0; i < self.repeatCount; i++) {
            string = self.dictionary[@(i)];
        }
    }];
}

- (void)testRemove {
    [self measureBlock:^{
        for (NSInteger i = 0; i < self.repeatCount; i++) {
            [self.dictionary removeObjectForKey:@(i)];
        }
    }];
}

- (void)testFastEnum {
    __block NSNumber *number;
    
    [self measureBlock:^{
        for (NSNumber *key in self.dictionary) {
            NSNumber *value = self.dictionary[key];
            number = value;
        }
    }];
}

@end