//
//  CascadeScrollView.m
//  Webmoebel
//
//  Created by Michael Zapf on 24.07.11.
//  Copyright 2011 mimagazine. All rights reserved.
//

#import "CascadeScrollView.h"


@implementation CascadeScrollView
@synthesize passthroughViews;

/*
- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
    
    }
    return self;
}
*/
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
   // L();
	CGPoint absolutePoint = [self convertPoint:point toView:self.superview];
   // DLog(@"passthourghviews:%@",passthroughViews);
	for (UIView* view in self.passthroughViews) {
     //   DLog(@"view.frame:%@; absoloute point:%@; point:%@",NSStringFromCGRect(view.frame),NSStringFromCGPoint(absolutePoint),NSStringFromCGPoint(point));
		if (CGRectContainsPoint(view.frame, absolutePoint) ) {
        
       //     DLog(@"view contains point");
			CGPoint newPoint = [self convertPoint:point toView:view];
			return [view hitTest:newPoint withEvent:event];
		}
	}
    return [super hitTest:point withEvent:event];
}




@end
