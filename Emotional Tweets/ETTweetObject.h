//
//  ETTweetObject.h
//  Emotional Tweets
//
//  Created by Robin Crorie on 09/06/2014.
//  Copyright (c) 2014 Robin Crorie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETTweetObject : NSObject

@property (nonatomic, strong) NSString * tweetHandle;
@property (nonatomic, strong) NSString * tweetText;
@property (nonatomic, strong) NSDate * postedDate;
@property (nonatomic, strong) UIImage * moodImage;

@end
