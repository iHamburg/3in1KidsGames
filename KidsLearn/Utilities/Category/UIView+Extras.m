//
//  UIView+Extras.m
//  XappCard
//
//  Created by  on 27.12.11.
//  Copyright (c) 2011 Xappsoft. All rights reserved.
//

#import "UIView+Extras.h"
#import <QuartzCore/QuartzCore.h>


@implementation UIView (Extras)


+ (id)viewFromNib:(NSString*)name{
	NSArray *bundle = [[NSBundle mainBundle] loadNibNamed:name owner:self options:nil];
	return [bundle objectAtIndex:0];
}


- (UIImage*)imageScreenshot{
	CGSize imageSize = self.bounds.size;
	
    UIGraphicsBeginImageContext(imageSize);
    CGContextRef imageContext = UIGraphicsGetCurrentContext();
	
	// mirroring context
	CGContextTranslateCTM(imageContext, 0.0, imageSize.height);
	CGContextScaleCTM(imageContext, 1.0, -1.0);
	
	
    [self.layer renderInContext: imageContext];
    UIImage* viewImage = UIGraphicsGetImageFromCurrentImageContext();
	
    UIGraphicsEndImageContext();
    return viewImage;
}

- (void)setImage:(UIImage *)image{
}


- (void)fadeIn {
	if (self.alpha == 1.0) {
		return;
	}
	
	[UIView beginAnimations:@"fadeIn" context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	
	self.alpha = 1.0;
	
	[UIView commitAnimations];
}

- (void)fadeOut {
	if (self.alpha == 0.0) {
		return;
	}
	
	[UIView beginAnimations:@"fadeOut" context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	
	self.alpha = 0.0;
	
	[UIView commitAnimations];
}


#pragma mark - Size
- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)original{
	CGRect frame = self.frame;
	frame.origin = original;
	self.frame = frame;
}

- (void)moveOrigin:(CGPoint)relativePoint{
	CGRect frame = self.frame;
	CGPoint origin = frame.origin;
	origin.x+=relativePoint.x;
	origin.y+=relativePoint.y;
	frame.origin = origin;
	self.frame = frame;
}

- (CGFloat)width{
	return self.bounds.size.width;
}
- (CGFloat)height{
	return self.bounds.size.height;
}

- (void)setWidth:(CGFloat)width{
	CGRect frame = self.frame;
	frame.size = CGSizeMake(width, self.height);
	
	self.frame = frame;
}
- (void)setHeight:(CGFloat)height{
	
	CGRect frame = self.frame;
	frame.size = CGSizeMake(self.width, height);
	self.frame = frame;
}

+ (CGSize)sizeForImage:(UIImage*)image withMinSide:(CGFloat)minSide{
	CGFloat width = image.size.width;
	CGFloat height = image.size.height;
	CGSize size;
	//	CGFloat minSide = 320;
	
	if (width>height) {
		size = CGSizeMake( width/height*minSide, minSide);
	}
	else{
		size = CGSizeMake( minSide, height/width*minSide);
	}
	return size;
}

#pragma mark - Gradient
- (void)applyGradientBorder:(unsigned int)edges indent:(CGFloat)indent {
	
	//apply gradient mask
	CALayer* maskLayer = [CALayer layer];
	CGRect frame = self.bounds;
	
	maskLayer.frame = frame;
	
	if (self.layer.borderWidth && self.layer.borderColor) {
		frame = CGRectInset(frame, self.layer.borderWidth, self.layer.borderWidth);
	}
	
	if (edges & kCALayerTopEdge) {
		CAGradientLayer* topGradientLayer = [CAGradientLayer layer];
		topGradientLayer.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), indent);
		
		topGradientLayer.colors = [NSArray arrayWithObjects:
								   (id)[[UIColor clearColor] CGColor],
								   (id)[[UIColor blackColor] CGColor],
								   nil];
		topGradientLayer.startPoint = CGPointMake(0.5,0.0);
		topGradientLayer.endPoint = CGPointMake(0.5,1.0);
		[maskLayer addSublayer:topGradientLayer];
		
		frame.origin.y = indent;
		frame.size.height -= indent;
	}
	
	if (edges & kCALayerBottomEdge) {
		CAGradientLayer* bottomGradientLayer = [CAGradientLayer layer];
		bottomGradientLayer.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMaxY(frame) - indent, CGRectGetWidth(frame), indent);
		
		bottomGradientLayer.colors = [NSArray arrayWithObjects:
									  (id)[[UIColor blackColor] CGColor],
									  (id)[[UIColor clearColor] CGColor],
									  nil];
		
		bottomGradientLayer.startPoint = CGPointMake(0.5,0.0);
		bottomGradientLayer.endPoint = CGPointMake(0.5,1.0);
		[maskLayer addSublayer:bottomGradientLayer];
		
		frame.size.height -= indent;
	}
	
	if (edges & kCALayerLeftEdge) {
		CAGradientLayer* leftGradientLayer = [CAGradientLayer layer];
		leftGradientLayer.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), indent, CGRectGetHeight(frame));
		
		leftGradientLayer.colors = [NSArray arrayWithObjects:
									(id)[[UIColor clearColor] CGColor],
									(id)[[UIColor blackColor] CGColor],
									nil];
		
		leftGradientLayer.startPoint = CGPointMake(0.0,0.5);
		leftGradientLayer.endPoint = CGPointMake(1.0,0.5);
		[maskLayer addSublayer:leftGradientLayer];
		
		frame.origin.x = indent;
		frame.size.width -= indent;
	}
	
	if (edges & kCALayerRightEdge) {
		CAGradientLayer* rightGradientLayer = [CAGradientLayer layer];
		rightGradientLayer.frame = CGRectMake(CGRectGetMaxX(frame) - indent, CGRectGetMinY(frame), indent, CGRectGetHeight(frame));
		
		rightGradientLayer.colors = [NSArray arrayWithObjects:
									 (id)[[UIColor blackColor] CGColor],
									 (id)[[UIColor clearColor] CGColor],
									 nil];
		
		rightGradientLayer.startPoint = CGPointMake(0.0,0.5);
		rightGradientLayer.endPoint = CGPointMake(1.0,0.5);
		[maskLayer addSublayer:rightGradientLayer];
		
		frame.size.width -= indent;
	}
	
	//at least the middle
	CALayer* middleLayer = [CALayer layer];
	middleLayer.backgroundColor = [UIColor blackColor].CGColor;
	middleLayer.frame = frame;
	[maskLayer addSublayer:middleLayer];
	
	if (self.layer.borderWidth && self.layer.borderColor) {
		CALayer* borderLayer = [CALayer layer];
		borderLayer.frame = self.bounds;
		borderLayer.borderColor = self.layer.borderColor;
		borderLayer.borderWidth = self.layer.borderWidth;
		[maskLayer addSublayer:borderLayer];
	}
	
	self.layer.mask = maskLayer;
}

- (void)applyShadowBorder:(unsigned int)edges withColor:(UIColor*)color indent:(CGFloat)indent {
	UIColor* shadowColor = (color)? color: [UIColor blackColor];
	CGRect frame = self.bounds;
	
	if (edges & kCALayerTopEdge) {
		CAGradientLayer* topGradientLayer = [CAGradientLayer layer];
		topGradientLayer.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), indent);
		
		topGradientLayer.colors = [NSArray arrayWithObjects:
								   (id)shadowColor.CGColor,
								   (id)[[UIColor clearColor] CGColor],
								   nil];
		topGradientLayer.startPoint = CGPointMake(0.5,0.0);
		topGradientLayer.endPoint = CGPointMake(0.5,1.0);
		[self.layer addSublayer:topGradientLayer];
	}
	
	if (edges & kCALayerBottomEdge) {
		CAGradientLayer* bottomGradientLayer = [CAGradientLayer layer];
		bottomGradientLayer.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMaxY(frame) - indent, CGRectGetWidth(frame), indent);
		
		bottomGradientLayer.colors = [NSArray arrayWithObjects:
									  (id)[[UIColor clearColor] CGColor],
									  (id)shadowColor.CGColor,
									  nil];
		
		bottomGradientLayer.startPoint = CGPointMake(0.5,0.0);
		bottomGradientLayer.endPoint = CGPointMake(0.5,1.0);
		[self.layer addSublayer:bottomGradientLayer];
	}
	
	if (edges & kCALayerLeftEdge) {
		CAGradientLayer* leftGradientLayer = [CAGradientLayer layer];
		leftGradientLayer.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), indent, CGRectGetHeight(frame));
		
		leftGradientLayer.colors = [NSArray arrayWithObjects:
									(id)shadowColor.CGColor,
									(id)[[UIColor clearColor] CGColor],
									nil];
		
		leftGradientLayer.startPoint = CGPointMake(0.0,0.5);
		leftGradientLayer.endPoint = CGPointMake(1.0,0.5);
		[self.layer addSublayer:leftGradientLayer];
	}
	
	if (edges & kCALayerRightEdge) {
		CAGradientLayer* rightGradientLayer = [CAGradientLayer layer];
		rightGradientLayer.frame = CGRectMake(CGRectGetMaxX(frame) - indent, CGRectGetMinY(frame), indent, CGRectGetHeight(frame));
		
		rightGradientLayer.colors = [NSArray arrayWithObjects:
									 (id)[[UIColor clearColor] CGColor],
									 (id)shadowColor.CGColor,
									 nil];
		
		rightGradientLayer.startPoint = CGPointMake(0.0,0.5);
		rightGradientLayer.endPoint = CGPointMake(1.0,0.5);
		[self.layer addSublayer:rightGradientLayer];
	}
}

#pragma mark -
- (void)removeAllSubviews{
	NSArray *subviews = self.subviews;
	for (UIView *v in subviews) {
		[v removeFromSuperview];
	}
}

- (void)setBGView:(NSString*)imgName{
	UIImageView *bgV = [[UIImageView alloc]initWithFrame:self.bounds];
	bgV.image = [UIImage imageNamed:imgName];
	bgV.tag = kTagBGV;
	[self addSubview:bgV];
}
@end
