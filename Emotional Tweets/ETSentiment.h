//
//  ETSentiment.h
//  Emotional Tweets
//
//  Created by Robin Crorie on 09/06/2014.
//  Copyright (c) 2014 Robin Crorie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETTweetObject.h"

@interface ETSentiment : NSObject

+ (CGFloat)getMoodValueForTweet:(ETTweetObject*)tweet error:(NSError**)error;
+ (NSData *)synchronousRequest:(NSURLRequest *)request error:(NSError **)error response:(NSURLResponse **)response;

@end
