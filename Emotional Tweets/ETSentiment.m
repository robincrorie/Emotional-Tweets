//
//  ETSentiment.m
//  Emotional Tweets
//
//  Created by Robin Crorie on 09/06/2014.
//  Copyright (c) 2014 Robin Crorie. All rights reserved.
//

#import "ETSentiment.h"

@implementation ETSentiment

+ (CGFloat)getMoodValueForTweet:(ETTweetObject*)tweet error:(NSError**)error
{
	NSString *path = [[NSString stringWithFormat:@"https://sentimentalsentimentanalysis.p.mashape.com/sentiment/current/classify_text/"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
	
	[request setHTTPMethod:@"POST"];
	[request setValue:@"uVayQDx0JnQf0Mcj3x8mDFUOSy2v1zH9" forHTTPHeaderField:@"X-Mashape-Authorization"];
	[request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
	
	NSString *postString = [NSString stringWithFormat:@"lang=en&text=%@", tweet.tweetText];
	[request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSHTTPURLResponse *response;
	NSData* xmlData = [self synchronousRequest:request error:&*error response:&response];
	if (*error) {
		return 0;
	}
	
	NSDictionary * jsonResults = [NSJSONSerialization JSONObjectWithData:xmlData options:0 error:&*error];
	if (*error) {
		return 0;
	}
	
	if ([jsonResults objectForKey:@"errors"]) {
		NSDictionary * errorDict = [jsonResults objectForKey:@"errors"];
		NSString * message = [[errorDict valueForKey:@"message"] objectAtIndex:0];
		NSNumber * code = [[errorDict valueForKey:@"code"] objectAtIndex:0];
		NSDictionary *errorDictionary = @{ NSLocalizedDescriptionKey : message};
		*error = [[NSError alloc] initWithDomain:@"ETRetrieveTweets" code:[code integerValue] userInfo:errorDictionary];
		return 0;
	}
	
	NSNumber * value = [jsonResults valueForKey:@"value"];
	
	return value.floatValue;
}

+ (NSData *)synchronousRequest:(NSURLRequest *)request error:(NSError **)error response:(NSURLResponse **)response  {
    NSData *data =[NSURLConnection sendSynchronousRequest:request returningResponse:response error:&*error];
    return data;
}

@end
