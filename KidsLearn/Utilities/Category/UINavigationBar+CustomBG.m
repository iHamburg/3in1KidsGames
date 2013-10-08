//
//  UINavigationBar+CustomBG.m
//  GoBeepit
//
//  Created by AppDevelopper on 07.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UINavigationBar+CustomBG.h"


@implementation UINavigationBar (UINavigationBar_CustomBG)

- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed: @"Navibar_bg.png"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
}

@end
