//
//  UIPopoverController+Extras.m
//  XappCard
//
//  Created by  on 22.12.11.
//  Copyright (c) 2011 Xappsoft. All rights reserved.
//

#import "UIPopoverController+Extras.h"

@implementation UIPopoverController (Extras)

- (void)setContentViewControllerInNavigationController:(UIViewController*)vc pingpang:(BOOL)pingpang{
//	BOOL result = NO;
	
	UINavigationController *navC = (UINavigationController*)self.contentViewController;
	
	if (![navC isKindOfClass:UINavigationController.class]) {
		NSAssert1(0, @"Pop doesn't contain NavigationsVC", nil);
	}

		
	[navC popToRootViewControllerAnimated:NO];
	[navC pushViewController:vc animated:NO];
	
	}

@end
