//
//  ETRetrieveTweets.h
//  Emotional Tweets
//
//  Created by Robin Crorie on 05/06/2014.
//  Copyright (c) 2014 Robin Crorie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETRetrieveTweets : NSObject

+ (NSMutableArray*)fetchTweetsForSearchTerm:(NSString*)searchTerm error:(NSError**)error;
+ (NSString *)getAccessToken:(NSError**)error;
+ (NSString *)base64EncodeString:(NSString *)strData;

@end
