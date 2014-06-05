//
//  ETSearchViewController.m
//  Emotional Tweets
//
//  Created by Robin Crorie on 05/06/2014.
//  Copyright (c) 2014 Robin Crorie. All rights reserved.
//

#import "ETSearchViewController.h"

@interface ETSearchViewController () <UITextFieldDelegate>
{
	IBOutlet UITextField * searchInput;
	IBOutlet UIButton * submitButton;
}

@end

@implementation ETSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self styleTextFields:self.view];
}

- (IBAction)submit:(id)sender
{
	[self performSegueWithIdentifier:@"submit" sender:self];
}

- (void)styleTextFields:(UIView*)view {
	
    for(id currentView in [view subviews]){
        if([currentView isKindOfClass:[UITextField class]]) {
			UITextField * currentField = currentView;
            // Change value of CGRectMake to fit ur need
            [currentView setLeftView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)]];
            [currentView setLeftViewMode:UITextFieldViewModeAlways];
			currentField.layer.masksToBounds=YES;
			currentField.layer.borderColor=[[UIColor colorWithRed:91.0/255.0 green:204.0/255.0 blue:253.0/255.0 alpha:1] CGColor];
			currentField.layer.borderWidth= 1.0f;
			currentField.tintColor = [UIColor colorWithRed:91.0/255.0 green:204.0/255.0 blue:253.0/255.0 alpha:1];
			currentField.delegate = self;
        }
		
        if([currentView respondsToSelector:@selector(subviews)]){
            [self styleTextFields:currentView];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
