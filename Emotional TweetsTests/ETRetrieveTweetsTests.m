//
//  ETRetrieveTweetsTests.m
//  Emotional Tweets
//
//  Test cases for ETRetrieveTweets
//
//  Created by Robin Crorie on 07/06/2014.
//  Copyright (c) 2014 Robin Crorie. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "ETRetrieveTweets.h"

@interface ETRetrieveTweetsTests : XCTestCase

@end

@implementation ETRetrieveTweetsTests

- (void)setUp {
    
}

- (void)tearDown {
    
}

- (void)testThatBase64EncodeStringWithEmptyStringReturnsEmptyString {

    NSString * expectedValue = @"";
    NSString * returnValue = [ETRetrieveTweets base64EncodeString:@""];
    XCTAssertTrue([returnValue isEqual:(expectedValue)], @"base64EncodeString returned %@ but %@ was expected.",returnValue,expectedValue);
    
}

- (void)testThatBase64EncodeStringEncodesToExpectedValue {
	
    NSString * expectedValue = @"dGVzdHN0cmluZw==";
    NSString * returnValue = [ETRetrieveTweets base64EncodeString:@"teststring"];
    XCTAssertTrue([returnValue isEqual:(expectedValue)], @"base64EncodeString returned %@ but %@ was expected.",returnValue,expectedValue);
    
}

- (void)testThatBase64EncodeStringEncodesSpecialCharacters {
	
    NSString * expectedValue = @"IUDCoyQlXiYqKClfK8Kh4oKsI8Ki4oiewqfCtuKAosKqwrrigJM=";
    NSString * returnValue = [ETRetrieveTweets base64EncodeString:@"!@£$%^&*()_+¡€#¢∞§¶•ªº–"];
    XCTAssertTrue([returnValue isEqual:(expectedValue)], @"base64EncodeString returned %@ but %@ was expected.",returnValue,expectedValue);
    
}

- (void)testThatGetAcessTokenReturnNonEmptyString {
	
	NSError * accessTokenError = nil;
    NSString * returnValue = [ETRetrieveTweets getAccessToken:&accessTokenError];
    XCTAssertTrue(returnValue.length > 0, @"getAccessToken did not return a string with length greater the 0.");
    
}

- (void)testGetAccessTokenWithInvalidBase64Encoding {
	
	id mock = [OCMockObject mockForClass:[ETRetrieveTweets class]];
	
    [[[[mock stub] classMethod] andReturn:@"wrongbase64encoding"] base64EncodeString:[OCMArg any]];
	
	NSError * error = nil;
	NSString * result = [ETRetrieveTweets getAccessToken:&error];
	
	XCTAssertNil(result, @"Returned an array when should be nil");
	XCTAssertTrue(error.code == 403, @"error code is wrong, epected %d but got %ld", 89, (long)error.code);
	
}

- (void)testFetchTweetsForSearchTermWithInvalidAccessToken {
	
	id mock = [OCMockObject mockForClass:[ETRetrieveTweets class]];
	
	NSError * error = nil;
    [[[[mock stub] classMethod] andReturn:@"wrongaccesstoken"] getAccessToken:[OCMArg anyObjectRef]];
	
	NSMutableArray * result = [ETRetrieveTweets fetchTweetsForSearchTerm:@"test" error:&error];
	
	XCTAssertNil(result, @"Returned an array when should be nil");
	XCTAssertTrue(error.code == 89, @"Error code is wrong, expected 89 but returned %ld", (long)error.code);
	
}

@end
