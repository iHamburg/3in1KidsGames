//
//  UIButton+Extras.m
//  XappCard
//
//  Created by  on 04.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "UIButton+Extras.h"

@implementation UIButton (Extras)

+ (UIButton*)buttonWithFrame:(CGRect)frame title:(NSString*)title image:(UIImage*)image target:(id)target actcion:(SEL)action{
	UIButton *b = [[UIButton alloc] initWithFrame:frame];
	if (title) {
		[b setTitle:title forState:UIControlStateNormal];
	}
	if (image) {
		[b setBackgroundImage:image forState:UIControlStateNormal];
	}
	[b addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	
	return b;
}
@end
