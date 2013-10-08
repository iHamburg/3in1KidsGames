//
//  UIViewController+Portrait.m
//  SportTraining_1_0
//
//  Created by  on 19.03.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "UIViewController+Portrait.h"

@implementation UIViewController (Portrait)

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
	return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}

@end
