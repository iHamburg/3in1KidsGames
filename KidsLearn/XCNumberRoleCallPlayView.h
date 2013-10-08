//
//  XCNumberRoleCallPlayView.h
//  KidsLearn
//
//  Created by  on 05.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "XCNumberPlayView.h"
#import "QuartzCore/QuartzCore.h"

@interface XCNumberRoleCallPlayView : XCNumberPlayView{
	NSArray *spriteNames;
	
	NSMutableArray *spriteRects;
	NSArray *spritePlayRects;
	
	
	UIBezierPath *pacmanOpenPath, *pacmanClosedPath;
	CAShapeLayer *shapeLayer;
	
	Sprite *box;
	CGPoint startPoint;
}

- (void)roleCall:(Sprite*)sprite;
- (void)roleCallwithInfo:(NSDictionary*)info;

- (void)jumpOut:(Sprite*)sprite;

@end
