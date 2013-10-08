//
//  TrianglePlayView.m
//  KidsLearn
//
//  Created by  on 25.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "TrianglePlayView.h"

@implementation TrianglePlayView

- (void)load{
	[super load];
	
	building = [Sprite spriteWithName:@"triangle_castle.png" origin:CGPointMake(300, 230)];
	building.transform = CGAffineTransformMakeScale(0.5, 0.5);
	
	t1 = [Sprite spriteWithName:@"triangle_roof_brown.png" origin:CGPointMake(300, 230)];
	t1.alpha = 0;
	t2 = [Sprite spriteWithName:@"triangle_roof_yellow.png" origin:CGPointMake(450, 315)];
	t2.alpha = 0;
	
	[self addSubview: building];
	[self addSubview:t1];
	[self addSubview:t2];
	
	
	
}

- (void)play{
//	[AudioController playShape:shapeTriangle delegate:nil];
	
    [super play];
    
	[UIView animateWithDuration:0.5 
					 animations:^(void){ // build 变大
						 building.transform = CGAffineTransformMakeScale(1.0, 1.0);
					 }
					 completion:^(BOOL finished){
						 if (!finished) 
							 return;
						 t1.alpha = 1;
						 [UIView animateWithDuration:0.5 animations:^(void){ // t1 放大
							 t1.transform = CGAffineTransformMakeScale(1.5, 1.5);
						 }completion:^(BOOL finished){
							 if (!finished) 
								 return;					
							 [UIView animateWithDuration:0.5 animations:^(void){ // t1 small
								 t1.transform = CGAffineTransformMakeScale(1.0, 1.0);
							 }completion:^(BOOL finished){
								 if (!finished) 
									 return;					
								 t1.alpha = 0;
								 t2.alpha = 1;
								 [UIView animateWithDuration:0.5 animations:^(void){ // t2 bigger
									 t2.transform = CGAffineTransformMakeScale(1.5, 1.5);
								 }completion:^(BOOL finished){
									 if (!finished) 
										 return;					
									 
									 [UIView animateWithDuration:0.5 animations:^(void){ // t2 smaller
										 t2.transform = CGAffineTransformMakeScale(1.0, 1.0);
									 }completion:^(BOOL finished){
										 if (isLeft) 
											 return;					
										 t2.alpha = 0;
										 [AudioController playShape:shapeTriangle delegate:nil];
										 
									 }];
								 }];
							 }];
						 }];
					 }];
}

@end
