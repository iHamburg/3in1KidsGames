//
//  UIView+Extras.h
//  XappCard
//
//  Created by  on 27.12.11.
//  Copyright (c) 2011 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTagBGV 789

@interface UIView (Extras)

+ (id)viewFromNib:(NSString*)name;

- (void)fadeIn;
- (void)fadeOut;


- (void)applyGradientBorder:(unsigned int)edges indent:(CGFloat)indent;
- (void)applyShadowBorder:(unsigned int)edges withColor:(UIColor*)color indent:(CGFloat)indent;


- (void)setSize:(CGSize)size;
- (void)setOrigin:(CGPoint)original;

- (void)moveOrigin:(CGPoint)relativePoint;
- (CGFloat)width;
- (CGFloat)height;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;


- (UIImage*)imageScreenshot;

+ (CGSize)sizeForImage:(UIImage*)image withMinSide:(CGFloat)minSide;

- (void)removeAllSubviews;
- (void)setBGView:(NSString*)imgName;
@end
