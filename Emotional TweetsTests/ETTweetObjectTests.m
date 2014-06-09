//
//  ETTweetObjectTests.m
//  Emotional Tweets
//
//  Test cases for ETTweetObject
//
//  Created by Robin Crorie on 09/06/2014.
//  Copyright (c) 2014 Robin Crorie. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "ETTweetObject.h"

@interface ETTweetObjectTests : XCTestCase

@property (nonatomic, strong) ETTweetObject *myETTweetObject;

@end

@implementation ETTweetObjectTests

- (void)setUp {
    
    [self setMyETTweetObject:[[ETTweetObject alloc]init]];
    
}

- (void)tearDown {
    
    [self setMyETTweetObject:nil];
    
}

- (void)testInitNotNil {
    
    XCTAssertNotNil(self.myETTweetObject, @"Test ETTweetObject object not instantiated");
}


@end
