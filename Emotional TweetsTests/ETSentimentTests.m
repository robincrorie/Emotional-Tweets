//
//  ETSentimentTests.m
//  Emotional Tweets
//
//  Test cases for ETSentiment
//
//  Created by Robin Crorie on 09/06/2014.
//  Copyright (c) 2014 Robin Crorie. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "ETSentiment.h"

@interface ETSentimentTests : XCTestCase

@property (nonatomic, strong) ETTweetObject *happyTweet;
@property (nonatomic, strong) ETTweetObject *indifferentTweet;
@property (nonatomic, strong) ETTweetObject *sadTweet;

@end

@implementation ETSentimentTests

- (void)setUp {
    self.happyTweet = [[ETTweetObject alloc] init];
	self.happyTweet.tweetText = @"I'm happy! #happytweet";
	
	self.sadTweet = [[ETTweetObject alloc] init];
	self.sadTweet.tweetText = @"I'm sad! #sadtweet";
	
	self.indifferentTweet = [[ETTweetObject alloc] init];
	self.indifferentTweet.tweetText = @"I'm indifferent! #whatevertweet";
}

- (void)tearDown {
    
}

- (void)testThatGetMoodValueForHappyTweetReturnsValueInCorrectRange {
	
	NSError * error = nil;
    CGFloat returnValue = [ETSentiment getMoodValueForTweet:self.happyTweet error:&error];
    XCTAssertTrue(returnValue >= 0.3, @"getMoodValueForTweet returned %f but a value greater than 0.3 was expected.",returnValue);
    
}

- (void)testThatGetMoodValueForIndifferentTweetReturnsValueInCorrectRange {
	
	NSError * error = nil;
    CGFloat returnValue = [ETSentiment getMoodValueForTweet:self.indifferentTweet error:&error];
    XCTAssertTrue(returnValue >=-0.3 && returnValue < 0.3, @"getMoodValueForTweet returned %f but a value greater than -0.3 and less than 0.3 was expected.",returnValue);
    
}

- (void)testThatGetMoodValueForSadTweetReturnsValueInCorrectRange {
	
	NSError * error = nil;
    CGFloat returnValue = [ETSentiment getMoodValueForTweet:self.sadTweet error:&error];
    XCTAssertTrue(returnValue < -0.3, @"getMoodValueForTweet returned %f but a value less than 0.3 was expected.",returnValue);
    
}

- (void)testMethodInvokingFromOtherMethodUsingMock {
    id mock = [OCMockObject niceMockForClass:[ETSentiment class]];
    id partialMock = [OCMockObject partialMockForObject:[[ETSentiment alloc] init]];
    NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *resp = [[NSURLResponse alloc] init];
	
    NSData *data = [[NSData alloc] init];
    NSError *error = [[NSError alloc] init];
    [[[partialMock stub] andReturn:data] synchronousRequest:request error:&error response:&resp];
    [ETSentiment getMoodValueForTweet:self.happyTweet error:&error];
    [mock verify];
}

- (void)testMethodGettingResponseNilFromOtherMethod {

    NSString* str = @"teststring";
    NSData* responseData = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError * error;
    
    NSURLResponse * response = [[NSURLResponse alloc] init];
    
    id mock = [OCMockObject niceMockForClass:[NSURLConnection class]];
    [[[mock stub] andReturn:responseData] sendSynchronousRequest:[OCMArg any] returningResponse:[OCMArg setTo:response] error:[OCMArg setTo:nil]];
    [ETSentiment getMoodValueForTweet:self.happyTweet error:&error];
    NSData* rData = [NSURLConnection sendSynchronousRequest:nil returningResponse:&response error:&error];
    
    XCTAssertEqualObjects(rData, responseData, @"Mocking doesn't work");
}

@end
