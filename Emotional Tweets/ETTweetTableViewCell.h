//
//  ETTweetTableViewCell.h
//  Emotional Tweets
//
//  Created by Robin Crorie on 07/06/2014.
//  Copyright (c) 2014 Robin Crorie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETTweetTableViewCell : UITableViewCell

@property (nonatomic) IBOutlet UILabel * tweetHandle;
@property (nonatomic) IBOutlet UITextView * tweetText;
@property (nonatomic) IBOutlet UILabel * tweetTime;
@property (nonatomic) IBOutlet UIImageView * tweetMood;

@end
