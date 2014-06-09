//
//  Loading.h
//  Own'd
//
//  Created by Robin Crorie on 15/01/2014.
//  Copyright (c) 2014 WebXr. All rights reserved.
//

#import "ETAppDelegate.h"

@interface Loading : UIView

@property (nonatomic, strong) UIWindow* window;
@property (nonatomic, strong) UIView * overlay;

- (void)show;
- (void)show:(CGRect)withFrame;
- (void)hide;

+ (Loading*)sharedInstance;

@end
