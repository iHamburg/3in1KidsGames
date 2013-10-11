//
//  UIButton+Extras.m
//  XappCard
//
//  Created by  on 04.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "UIButton+Extras.h"
#import "Macros.h"
@implementation UIButton (Extras)

+ (UIButton*)buttonWithFrame:(CGRect)frame title:(NSString*)title imageName:(NSString*)imageName target:(id)target action:(SEL)action{
	UIButton *b = [[UIButton alloc] initWithFrame:frame];
	if (title) {
		[b setTitle:title forState:UIControlStateNormal];
	}
	if (imageName) {

		[b setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
	}
	
	[b addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	
	return b;
}

+ (UIButton*)buttonWithFrame:(CGRect)frame title:(NSString*)title image:(UIImage*)image target:(id)target action:(SEL)action{
	UIButton *b = [[UIButton alloc] initWithFrame:frame];
	if (!(ISEMPTY(title))) {
		[b setTitle:title forState:UIControlStateNormal];
	}
	if (!ISEMPTY(image)) {
		[b setImage:image forState:UIControlStateNormal];
	}
	
	[b addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	
	return b;
}


+ (UIButton*)buttonWithFrame:(CGRect)frame title:(NSString*)title bgImageName:(NSString*)imageName target:(id)target action:(SEL)action{
	UIButton *b = [[UIButton alloc] initWithFrame:frame];
	if (!ISEMPTY(title)) {
		[b setTitle:title forState:UIControlStateNormal];
	}
	if (!ISEMPTY(imageName)) {
		[b setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
	}
	
	[b addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	
	return b;
	
}

+ (UIButton*)buttonWithImageName:(NSString*)imgName target:(id)target action:(SEL)action{
	UIImage *img = [UIImage imageNamed:imgName];
	
	if (img) {
		CGSize size = img.size;
		UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
		[b setImage:img forState:UIControlStateNormal];
		return b;
	}
	else{
//		[[NSException exceptionWithName:NSInvalidArgumentException reason:@"nil image" userInfo:nil] raise];
		NSLog(@"Warning: image is nil");
		return nil;

	}
			
	
}
@end
