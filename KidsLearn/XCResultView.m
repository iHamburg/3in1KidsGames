//
//  XCDrawResult.m
//  KidsLearn
//
//  Created by XC on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XCResultView.h"


@implementation XCResultView
@synthesize shape, color, numberIndex;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//		bgV = [[UIImageView alloc]initWithFrame:self.bounds];
		L();


		[self setBGView:@"BG_DisplayResult.png"];

		drawV = [[UIImageView alloc]initWithFrame:self.bounds];
    }
    return self;
}

- (void)setup{
	
	L();
	NSLog(@"shape: %d", shape);
    NSLog(@"color: %d", color);
    NSLog(@"number: %d", numberIndex);
	
	
	[drawV removeFromSuperview];
	
	
    
	CGPoint pieceOrigin;


	UIGraphicsBeginImageContext(self.bounds.size);


    
    UIColor *colorDraw = [[Controller sharedInstance]colorWithIndex:color];
	
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 20.0);
    
    CGContextSetStrokeColorWithColor(context, colorDraw.CGColor);
	
	for (int i=0; i<numberIndex+1; i++) {
		
		if (i <9) {
			pieceOrigin = CGPointMake(StartX+i%3*(Width), StartY+i/3*(Hight));
		}
		else {
			pieceOrigin = CGPointMake(20, StartY+Hight);
		}
		
		
		if (shape == shapeCircle) {
			CGRect rec4Circle = CGRectMake(pieceOrigin.x, pieceOrigin.y, 150, 150);
			CGContextAddEllipseInRect(context, rec4Circle);
			
		}
		else if (shape == shapeSquare) {
			CGRect rec4Rectangle = CGRectMake(pieceOrigin.x, pieceOrigin.y, 150, 150);
			CGContextAddRect(context, rec4Rectangle);
			
		}
		else if (shape == shapeTriangle) {
			CGContextMoveToPoint(context, pieceOrigin.x+Width/2, pieceOrigin.y+DisY);
			CGContextAddLineToPoint(context, pieceOrigin.x+DisX, pieceOrigin.y+Hight-DisY);
			CGContextAddLineToPoint(context, pieceOrigin.x+Width-DisX, pieceOrigin.y+Hight-DisY);
			CGContextAddLineToPoint(context, pieceOrigin.x+Width/2, pieceOrigin.y+DisY);
			CGContextAddLineToPoint(context, pieceOrigin.x+DisX, pieceOrigin.y+Hight-DisY);
			
		}
		else if (shape == shapeRectangle) {
			CGContextMoveToPoint(context, pieceOrigin.x+DisWidth, pieceOrigin.y+DisHight);
			CGContextAddLineToPoint(context, pieceOrigin.x+DisWidth, pieceOrigin.y+Hight-DisY);
			CGContextAddLineToPoint(context, pieceOrigin.x+Width-DisWidth, pieceOrigin.y+Hight-DisY);
			CGContextAddLineToPoint(context, pieceOrigin.x+Width-DisWidth, pieceOrigin.y+DisHight);
			CGContextAddLineToPoint(context, pieceOrigin.x+DisWidth, pieceOrigin.y+DisHight);
			CGContextAddLineToPoint(context, pieceOrigin.x+DisWidth, pieceOrigin.y+Hight-DisY);
			
		}
		else if (shape == shapePentagon) {
			
			CGContextMoveToPoint(context, pieceOrigin.x+0.4*PenUnit, pieceOrigin.y);
			CGContextAddLineToPoint(context, pieceOrigin.x, pieceOrigin.y+0.30*PenUnit);
			CGContextAddLineToPoint(context, pieceOrigin.x+0.15*PenUnit, pieceOrigin.y+0.78*PenUnit);
			CGContextAddLineToPoint(context, pieceOrigin.x+0.66*PenUnit, pieceOrigin.y+0.78*PenUnit);
			CGContextAddLineToPoint(context, pieceOrigin.x+0.81*PenUnit, pieceOrigin.y+0.30*PenUnit);
			CGContextAddLineToPoint(context, pieceOrigin.x+0.4*PenUnit, pieceOrigin.y);
			CGContextAddLineToPoint(context, pieceOrigin.x, pieceOrigin.y+0.30*PenUnit);
			
			
		}
		else if (shape == shapeDiamond) {
			CGContextMoveToPoint(context, pieceOrigin.x+Width/2, pieceOrigin.y+DisDiamond);
			CGContextAddLineToPoint(context, pieceOrigin.x+DisDiamond, pieceOrigin.y+Hight/2);
			CGContextAddLineToPoint(context, pieceOrigin.x+Width/2, pieceOrigin.y+Hight-DisDiamond);
			CGContextAddLineToPoint(context, pieceOrigin.x+Width-DisDiamond, pieceOrigin.y+Hight/2);
			CGContextAddLineToPoint(context, pieceOrigin.x+Width/2, pieceOrigin.y+DisDiamond);
			CGContextAddLineToPoint(context, pieceOrigin.x+DisDiamond, pieceOrigin.y+Hight/2);
		}
		else {
			NSLog(@"unknown shape:%d",shape);
		}
		CGContextStrokePath(context);
	}

	UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	drawV.image = im;
	[self addSubview:drawV];

}
@end
