//
//  UIViewController+Landscape.m
//  SportTraining_1_0
//
//  Created by  on 19.03.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "UIViewController+Landscape.h"

@implementation UIViewController (Landscape)

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
	return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}
@end
