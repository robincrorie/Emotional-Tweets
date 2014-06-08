//
//  ETTweetTableViewController.m
//  Emotional Tweets
//
//  Created by Robin Crorie on 05/06/2014.
//  Copyright (c) 2014 Robin Crorie. All rights reserved.
//

#import "ETTweetTableViewController.h"
#import "ETTweetTableViewCell.h"

@interface ETTweetTableViewController ()
{
	NSDateFormatter * dateFormatter;
}

@end

@implementation ETTweetTableViewController
@synthesize tweets;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	dateFormatter = [[NSDateFormatter alloc] init];
	NSLocale * loc = [[NSLocale alloc] initWithLocaleIdentifier:@"en_UK"];
	[dateFormatter setLocale:loc];
	[dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss ZZZZ yyyy"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ETTweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tweet" forIndexPath:indexPath];
    
	NSDictionary * tweet = [tweets objectAtIndex:indexPath.row];

    cell.tweetText.text = [tweet valueForKey:@"text"];
	cell.tweetHandle.text = [@"@" stringByAppendingString:[[tweet objectForKey:@"user"] valueForKey:@"screen_name"]];
	
	cell.tweetText.contentInset = UIEdgeInsetsMake(-10,-5,-10,-5);
	cell.tweetText.textColor = [UIColor darkGrayColor];
	
	NSLog(@"Created at: %@", [tweet valueForKey:@"created_at"]);
	
	NSDate * postedDate = [dateFormatter dateFromString:[tweet valueForKey:@"created_at"]];
	int difference = abs([postedDate timeIntervalSinceNow]);
	
	if (difference < 60) {
		cell.tweetTime.text = [NSString stringWithFormat:@"%ds ago", difference];
	} else {
		difference = difference / 60;
		if (difference < 60) {
			cell.tweetTime.text = [NSString stringWithFormat:@"%dm ago", difference];
		} else {
			difference = difference / 60;
			if (difference < 24) {
				cell.tweetTime.text = [NSString stringWithFormat:@"%dh ago", difference];
			} else {
				difference = difference / 24;
				cell.tweetTime.text = [NSString stringWithFormat:@"%ddays ago", difference];
			}
		}
	}
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary * tweet = [tweets objectAtIndex:indexPath.row];
	NSString * tweetText = [tweet valueForKey:@"text"];

	return [self heightForCellWithLabelContainingString:tweetText];
}

- (CGFloat)heightForCellWithLabelContainingString:(NSString*)string
{
    CGFloat horizontalPadding = 110;
    CGFloat verticalPadding = 70;
    CGFloat widthOfTextView = self.view.frame.size.width - horizontalPadding;
	
	NSDictionary *stringAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [UIFont systemFontOfSize:15], NSFontAttributeName,
                                      [UIColor darkGrayColor], NSForegroundColorAttributeName,
                                      nil];
	
    CGRect newRect = [string boundingRectWithSize:(CGSize){widthOfTextView, CGFLOAT_MAX}
												options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
											 attributes:stringAttributes context:nil];
	
    CGFloat height = ceilf(newRect.size.height);
    
	return height + verticalPadding;
}

@end
