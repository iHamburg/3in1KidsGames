//
//  UIButton+Extras.h
//  XappCard
//
//  Created by  on 04.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extras)

+ (UIButton*)buttonWithFrame:(CGRect)frame title:(NSString*)title image:(UIImage*)image target:(id)target actcion:(SEL)action;

@end
