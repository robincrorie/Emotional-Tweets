//
//  ETTweetTableViewCell.m
//  Emotional Tweets
//
//  Created by Robin Crorie on 07/06/2014.
//  Copyright (c) 2014 Robin Crorie. All rights reserved.
//

#import "ETTweetTableViewCell.h"

@implementation ETTweetTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
