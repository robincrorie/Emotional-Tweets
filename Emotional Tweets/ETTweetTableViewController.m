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
	cell.tweetHandle.text = [[tweet objectForKey:@"user"] valueForKey:@"screen_name"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary * tweet = [tweets objectAtIndex:indexPath.row];
	NSString * tweetText = [tweet valueForKey:@"text"];

	return 90;
//	return [self heightForCellWithLabel: containingString:<#(NSString *)#>]
}

- (CGFloat)heightForCellWithLabel:(UILabel*)labelView containingString:(NSString*)string
{
    CGFloat horizontalPadding = 0;
    CGFloat verticalPadding = 69;
    CGFloat widthOfTextView = labelView.frame.size.width - horizontalPadding;
	
	
	UIFont *font = [UIFont systemFontOfSize:18];
	NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: font}];
	CGRect rect = [attributedText boundingRectWithSize:(CGSize){widthOfTextView, CGFLOAT_MAX}
											   options:NSStringDrawingUsesLineFragmentOrigin
											   context:nil];
	CGFloat height = rect.size.height + verticalPadding;
    
	return height;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
