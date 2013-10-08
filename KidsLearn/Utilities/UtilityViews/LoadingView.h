//
//  LoadingView.h
//  TheBootic
//
//  Created by AppDevelopper on 01.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utilities.h"

CGPathRef NewPathWithRoundRect(CGRect rect, CGFloat cornerRadius);

/*
 1. addInView + remove
 
 2. showTitle inView, automatische remove
 
 */

@interface LoadingView : UIView {
	
}

+ (LoadingView*)sharedLoadingView;


- (void)addInView:(UIView*)aSuperview;

- (void)showTitle:(NSString*)title inView:(UIView*)aSuperview;
- (void)removeView;

@end
