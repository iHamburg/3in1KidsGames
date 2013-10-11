//
//  XCShapeView.m
//  KidsLearn
//
//  Created by XC on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XCShapeView.h"

@implementation XCShapeView


@synthesize drawOrigin, delegate,strokeColor;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     
		[self load];
    }
    return self;
}

- (void)awakeFromNib{

	[self load];
}

- (void)load{
	UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
	[self addGestureRecognizer:tap];
	
	self.backgroundColor = [UIColor clearColor];
	
	drawOrigin = CGPointMake(100, 100);
	strokeColor = [UIColor whiteColor];

}

- (void)handleTap:(UITapGestureRecognizer*)gesture{
    
    
    CGPoint oldpoint = [gesture locationInView:self];
	CGPoint point = CGPointMake(oldpoint.x-drawOrigin.x, oldpoint.y-drawOrigin.y);

//    NSLog(@"oldpoint:%@,point:%@",NSStringFromCGPoint(oldpoint),NSStringFromCGPoint(point));
//    CGRect rectCircle = CGRectMake(130, 343, 150, 150);
    CGRect rectCircle = CGRectMake(30, 20, 150, 150);
    if (CGRectContainsPoint(rectCircle, point)) {

		[delegate shapeView:self didClickShape:shapeCircle];
//        NSLog(@"circleTapped");
        
    }
    CGRect rectSquare = CGRectMake(300, 20, 150, 150);
    if (CGRectContainsPoint(rectSquare, point)) {
        
//          [chooseVC shapeClicked:shapeSquare];
		[delegate shapeView:self didClickShape:shapeSquare];

    
    }
    CGRect rectTriangle = CGRectMake(575, 20, 150, 120);
    if (CGRectContainsPoint(rectTriangle, point)) {

		[delegate shapeView:self didClickShape:shapeTriangle];

    }
    CGRect rectRectangle = CGRectMake(10, 230, 200, 150);
    if (CGRectContainsPoint(rectRectangle, point)) {

		[delegate shapeView:self didClickShape:shapeRectangle];

    }
    CGRect rectPentagon = CGRectMake(292, 195, 166, 180);
    if (CGRectContainsPoint(rectPentagon, point)) {

		[delegate shapeView:self didClickShape:shapePentagon];

    }
    CGRect rectDiamond = CGRectMake(575, 195, 150, 180);
    if (CGRectContainsPoint(rectDiamond, point)) {

		[delegate shapeView:self didClickShape:shapeDiamond];

    }    
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
	
	L();
	
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 20.0);
    
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
	
	CGContextTranslateCTM(context, drawOrigin.x, drawOrigin.y);
    
    //draw circle
    CGRect rectangle4Circle = CGRectMake(30,20,150,150);
    CGContextAddEllipseInRect(context, rectangle4Circle);

    
    //draw square
    CGRect rectangle4Rectangle = CGRectMake(300, 20, 150, 150);
    CGContextAddRect(context, rectangle4Rectangle);
    //    CGContextFillRect(context, rectangle4Rectangle);
    
    //draw triangle
    CGContextMoveToPoint(context, 650, 30);
    CGContextAddLineToPoint(context, 575, 160);
    CGContextAddLineToPoint(context, 725, 160);
    CGContextAddLineToPoint(context, 650, 30);
    CGContextAddLineToPoint(context, 575, 160);
    
    //draw rectangle
    CGContextMoveToPoint(context, 10, 250);
    CGContextAddLineToPoint(context, 210, 250);
    CGContextAddLineToPoint(context, 210, 350);
    CGContextAddLineToPoint(context, 10, 350);
    CGContextAddLineToPoint(context, 10, 250);
    CGContextAddLineToPoint(context, 210, 250);
    
    //draw pentagon
    CGContextMoveToPoint(context, 375, 205);
    CGContextAddLineToPoint(context, 292, 266);
    CGContextAddLineToPoint(context, 323, 364);
    CGContextAddLineToPoint(context, 427, 364);
    CGContextAddLineToPoint(context, 458, 266);
    CGContextAddLineToPoint(context, 375, 205);
    CGContextAddLineToPoint(context, 292, 266);
    
    //draw diamond
    CGContextMoveToPoint(context, 650, 220);
    CGContextAddLineToPoint(context, 575, 295);
    CGContextAddLineToPoint(context, 650, 370);
    CGContextAddLineToPoint(context, 725, 295);
    CGContextAddLineToPoint(context, 650, 220);
    CGContextAddLineToPoint(context, 575, 295);
    
    
    CGContextStrokePath(context);
    
    
    
}



@end
