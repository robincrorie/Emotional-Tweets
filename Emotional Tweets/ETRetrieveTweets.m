//
//  ETRetrieveTweets.m
//  Emotional Tweets
//
//  Created by Robin Crorie on 05/06/2014.
//  Copyright (c) 2014 Robin Crorie. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#import "ETRetrieveTweets.h"
#import "ETSentiment.h"
#import "ETTweetObject.h"

@implementation ETRetrieveTweets

+ (NSMutableArray*)fetchTweetsForSearchTerm:(NSString*)searchTerm error:(NSError**)error
{
	
	NSString *path = [[NSString stringWithFormat:@"https://api.twitter.com/1.1/search/tweets.json?q=%@&result_type=mixed&count=10", searchTerm] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
	
	[request setHTTPMethod:@"GET"];
	[request setValue:[@"Bearer " stringByAppendingString:[self getAccessToken:&*error]] forHTTPHeaderField:@"Authorization"];
	[request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
	
	NSHTTPURLResponse *response;
	NSData* xmlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
	
	NSString *theResult = [[NSString alloc] initWithBytes:[xmlData bytes] length:[xmlData length] encoding:NSUTF8StringEncoding];
	NSLog(@"%@", theResult);
	
	NSError * jsonParsingError;
	NSDictionary * jsonResults = [NSJSONSerialization JSONObjectWithData:xmlData options:0 error:&jsonParsingError];
	
	if ([jsonResults objectForKey:@"errors"]) {
		NSDictionary * errorDict = [jsonResults objectForKey:@"errors"];
		NSString * message = [[errorDict valueForKey:@"message"] objectAtIndex:0];
		NSNumber * code = [[errorDict valueForKey:@"code"] objectAtIndex:0];
		NSDictionary *errorDictionary = @{ NSLocalizedDescriptionKey : message};
		*error = [[NSError alloc] initWithDomain:@"ETRetrieveTweets" code:[code integerValue] userInfo:errorDictionary];
		return nil;
	}
	
	NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
	NSLocale * loc = [[NSLocale alloc] initWithLocaleIdentifier:@"en_UK"];
	[dateFormatter setLocale:loc];
	[dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss ZZZZ yyyy"];
	
	NSMutableArray * tweets = [[NSMutableArray alloc] init];
	
	for (NSDictionary * tweetDic in [jsonResults objectForKey:@"statuses"]) {
		ETTweetObject * tweet = [[ETTweetObject alloc] init];
		tweet.tweetHandle = [@"@" stringByAppendingString:[[tweetDic objectForKey:@"user"] valueForKey:@"screen_name"]];
		tweet.tweetText = [tweetDic valueForKey:@"text"];
		tweet.postedDate = [dateFormatter dateFromString:[tweetDic valueForKey:@"created_at"]];
		
		CGFloat moodValue = [ETSentiment getMoodValueForTweet:tweet error:&*error];
		if (moodValue < -0.3) {
			tweet.moodImage = [UIImage imageNamed:@"FaceSad"];
		} else if (moodValue > -0.3 && moodValue < 0.3) {
			tweet.moodImage = [UIImage imageNamed:@"FaceIndifferent"];
		} else if (moodValue > 0.3) {
			tweet.moodImage = [UIImage imageNamed:@"FaceHappy"];
		}
		
		[tweets addObject:tweet];
	}
	
	return tweets;
}

+ (NSString *)getAccessToken:(NSError**)error
{
	NSString *consumerKey = @"uR5NOvcY91D6B5bbsUhV2KdrO";

	NSString *consumerSecret = @"b2K0gppRmUqbXuFg1YwUwuwTglB53QfnjHTKpGlP8AUFOeuXjo";

	NSString *consumerKeyRFC1738 = [consumerKey stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];

	NSString *consumerSecretRFC1738 = [consumerSecret stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];

	NSString *concatKeySecret = [[consumerKeyRFC1738 stringByAppendingString:@":"] stringByAppendingString:consumerSecretRFC1738];

	NSString *concatKeySecretBase64 = [self base64EncodeString:concatKeySecret];

	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.twitter.com/oauth2/token"]];

	[request setHTTPMethod:@"POST"];

	[request setValue:[@"Basic " stringByAppendingString:concatKeySecretBase64] forHTTPHeaderField:@"Authorization"];

	[request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];

	NSString *str = @"grant_type=client_credentials";

	NSData *httpBody = [str dataUsingEncoding:NSUTF8StringEncoding];

	[request setHTTPBody:httpBody];

	NSError * connectionError = nil;
	NSHTTPURLResponse *response;
	NSData* xmlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
	
	if (connectionError) {
		*error = connectionError;
		return nil;
	}
	
	if (response.statusCode == 200) {
		
		NSError * jsonParsingError;
		NSDictionary * jsonResults = [NSJSONSerialization JSONObjectWithData:xmlData options:0 error:&jsonParsingError];
		
		if ([[jsonResults valueForKey:@"token_type"] isEqualToString:@"bearer"]) {
			NSString * access_token = [jsonResults valueForKey:@"access_token"];
			return access_token;
		}
	} else {
		NSDictionary *errorDictionary = @{ NSLocalizedDescriptionKey : [NSString stringWithFormat:@"Error, responded with status code: %ld", (long)response.statusCode]};
		*error = [[NSError alloc] initWithDomain:@"ETRetrieveTweets" code:response.statusCode userInfo:errorDictionary];
	}
	
	return nil;
}

+ (NSString *)base64EncodeString:(NSString *)strData {
	
	NSData *nsdata = [strData dataUsingEncoding:NSUTF8StringEncoding];
	
	NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
	
	return base64Encoded;
}

@end
