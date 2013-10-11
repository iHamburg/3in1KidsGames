//
//  UIButton+Extras.h
//  XappCard
//
//  Created by  on 04.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extras)


+ (UIButton*)buttonWithFrame:(CGRect)frame title:(NSString*)title image:(UIImage*)image target:(id)target action:(SEL)action;
+ (UIButton*)buttonWithFrame:(CGRect)frame title:(NSString*)title imageName:(NSString*)imageName target:(id)target action:(SEL)action;
+ (UIButton*)buttonWithFrame:(CGRect)frame title:(NSString*)title bgImageName:(NSString*)imageName target:(id)target action:(SEL)action;
+ (UIButton*)buttonWithImageName:(NSString*)imgName target:(id)target action:(SEL)action;


@end
