//
//  ETRetrieveTweets.m
//  Emotional Tweets
//
//  Created by Robin Crorie on 05/06/2014.
//  Copyright (c) 2014 Robin Crorie. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#import "ETRetrieveTweets.h"

@implementation ETRetrieveTweets

- (void)fetchTweetsForSearchTerm:(NSString*)searchTerm
{
	
}

- (void)fetchedData:(NSData *)responseData {

    NSError* error;
    NSDictionary* json = [NSJSONSerialization
						  JSONObjectWithData:responseData
						  
						  options:kNilOptions
						  error:&error];
	
    NSArray* latestLoans = [json objectForKey:@""];
}

@end
