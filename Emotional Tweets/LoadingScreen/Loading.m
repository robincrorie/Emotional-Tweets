//
//  Loading.m
//  Own'd
//
//  Created by Robin Crorie on 15/01/2014.
//  Copyright (c) 2014 WebXr. All rights reserved.
//

#import "Loading.h"

@implementation Loading
@synthesize overlay, window;

+ (Loading*)sharedInstance
{
	static dispatch_once_t once;
	static Loading * sharedInstance;
	dispatch_once(&once, ^{
		sharedInstance = [[self alloc] init];
	});
	
	return sharedInstance;
}

- (void)show
{
	window = [UIApplication sharedApplication].keyWindow;
	
	[self show:CGRectMake(0, 64, window.frame.size.width, window.frame.size.height - 64)];
}

- (void)show:(CGRect)withFrame
{
	overlay = [[UIView alloc] initWithFrame:withFrame];
	overlay.backgroundColor = [UIColor blackColor];
	overlay.alpha = 0;
	
	UIActivityIndicatorView * spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	CGFloat posX = ((overlay.frame.size.width/2) - (spinner.frame.size.width/2));
	CGFloat posY = ((overlay.frame.size.height/2) - (spinner.frame.size.height/2));
	[spinner setFrame:CGRectMake(posX, posY, spinner.frame.size.width, spinner.frame.size.height)];
	[spinner startAnimating];
	[overlay addSubview:spinner];
	
	
	UIWindow *loadingDisplaywindow = [[[UIApplication sharedApplication] delegate] window];;
	for (UIWindow *testWindow in [[UIApplication sharedApplication] windows])
	{
		if (![[testWindow class] isEqual:[UIWindow class]])
		{
			loadingDisplaywindow = testWindow;
			break;
		}
	}
	[loadingDisplaywindow addSubview:overlay];
	
	[UIView animateWithDuration:0.5 delay:0
						options: UIViewAnimationOptionCurveEaseInOut
					 animations:^{
						 overlay.alpha = 0.4;
					 }
					 completion:nil];
}

- (void)hide
{
	[UIView animateWithDuration:0.5 delay:0
						options: UIViewAnimationOptionCurveEaseInOut
					 animations:^{
						 overlay.alpha = 0;
					 }
					 completion:^(BOOL finished) {
						 [overlay removeFromSuperview];
					 }];
}

@end
