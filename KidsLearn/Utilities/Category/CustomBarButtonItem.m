//
//  CustomBarButtonItem.m
//  XappCard
//
//  Created by  on 02.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "CustomBarButtonItem.h"

@implementation CustomBarButtonItem
- (id) initWithImage:(UIImage *)image title:(NSString *)title target:(id)target action:(SEL)action {
	
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIFont *font = [UIFont boldSystemFontOfSize:13];
    barButton.titleLabel.font = font;
    barButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
    barButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 5);
    [barButton setImage:image forState:UIControlStateNormal];
    [barButton setTitle:title forState:UIControlStateNormal];
    [barButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [barButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [barButton setTitleShadowColor:[[UIColor blackColor] colorWithAlphaComponent:0.5] forState:UIControlStateNormal];
//    [barButton setBackgroundImage:[UIImage imageNamed:@"bar-button-item-background.png"] forState:UIControlStateNormal];
    barButton.frame = CGRectMake(0, 0, image.size.width + 15 + [title sizeWithFont:font].width, 30);
	
    if (self = [super initWithCustomView:barButton]) {
        self.target = target;
        self.action = action;
		[barButton addTarget:target
					  action:action
			forControlEvents:UIControlEventTouchUpInside];

    }
	
	
	
    return self;
}

- (id) initWithImage2:(UIImage *)image title:(NSString *)title target:(id)target action:(SEL)action {
	
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIFont *font = [UIFont boldSystemFontOfSize:13];
    barButton.titleLabel.font = font;
    barButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
    barButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 5);
    [barButton setImage:image forState:UIControlStateNormal];
    [barButton setTitle:title forState:UIControlStateNormal];
    [barButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [barButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [barButton setTitleShadowColor:[[UIColor blackColor] colorWithAlphaComponent:0.5] forState:UIControlStateNormal];
	
	//    [barButton setBackgroundImage:[UIImage imageNamed:@"bar-button-item-background.png"] forState:UIControlStateNormal];
  
	barButton.frame = CGRectMake(0, 0, image.size.width + 15 + [title sizeWithFont:font].width, 35);
	
    if (self = [super initWithCustomView:barButton]) {
        self.target = target;
        self.action = action;
    }
	
    return self;
}

@end


@implementation UIBarButtonItem (CustomBarButtonItem)

+ (UIBarButtonItem *) barButtonItemWithImage:(UIImage *)image title:(NSString *)title target:(id)target action:(SEL)action {
    return [[CustomBarButtonItem alloc] initWithImage:image title:title target:target action:action];
}

@end
