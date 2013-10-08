//
//  PentagonPlayView.m
//  KidsLearn
//
//  Created by  on 25.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "PentagonPlayView.h"

@implementation PentagonPlayView

- (void)load{
	[super load];
	house = [Sprite spriteWithName:@"pentagon_house.png" origin:CGPointMake(370, 180)];
	house.transform = CGAffineTransformMakeScale(0.5, 0.5);
	
	e1 = [Sprite spriteWithName:@"pentagon_edge1.png" origin:CGPointMake(520, 450)];
	e1.alpha = 0;
	
	e2 = [Sprite spriteWithName:@"pentagon_edge2.png" origin:CGPointMake(390, 345)];
	e2.alpha = 0;

	e3 = [Sprite spriteWithName:@"pentagon_edge3.png" origin:CGPointMake(430, 220)];
	e3.alpha = 0;

	e4 = [Sprite spriteWithName:@"pentagon_edge4.png" origin:CGPointMake(570, 220)];
	e4.alpha = 0;

	e5 = [Sprite spriteWithName:@"pentagon_edge5.png" origin:CGPointMake(640, 345)];
	e5.alpha = 0;

	animal = [Sprite spriteWithName:@"pentagon_rabbit.png" origin:CGPointMake(530, 340)];
	animal.alpha = 0;
	
	[self addSubview:animal];
	[self addSubview:house];
	[self addSubview:e1];
	[self addSubview:e2];
	[self addSubview:e3];
	[self addSubview:e4];
	[self addSubview:e5];
	
	
}

- (void)play{
//	[AudioController playShape:shapePentagon delegate:nil];
	
    [super play];
    
	[UIView animateWithDuration:1 
					 animations:^(void){ // build 变大
						 house.transform = CGAffineTransformMakeScale(1, 1);
					 }
					 completion:^(BOOL finished){
						 if (isLeft) 
							 return;
						 
						 [UIView animateWithDuration:1 animations:^(void){ // show 1
							 [AudioController playNumber:0 delegate:nil];
							 e1.alpha = 1;
						 }completion:^(BOOL finished){
							 if (isLeft) 
								 return;					
							 [UIView animateWithDuration:1 animations:^(void){ // show 2
								 [AudioController playNumber:1 delegate:nil];

								 e2.alpha = 1;
							 } completion:^(BOOL finished){
								 if (isLeft) 
									 return;
								 [UIView animateWithDuration:1 animations:^(void){ //show 3
									 [AudioController playNumber:2 delegate:nil];

									 e3.alpha = 1;
								 } completion:^(BOOL finished){
									 if (isLeft) 
										 return;
									  [AudioController playNumber:3 delegate:nil];
									 [UIView animateWithDuration:1 animations:^(void){ //show  4
										 e4.alpha = 1;
									 } completion:^(BOOL finished){
										 if (isLeft) 
											 return;
										  [AudioController playNumber:4 delegate:nil];
										 [UIView animateWithDuration:1 animations:^(void){ // show 5
											 e5.alpha = 1;
										 } completion:^(BOOL finished){
											 if (isLeft) 
												 return;
											 animal.alpha = 1;
											 [UIView animateWithDuration:1 animations:^(void){ // hidden all, animal show
												 e1.alpha = 0;
												 e2.alpha = 0;
												 e3.alpha = 0;
												 e4.alpha = 0;
												 e5.alpha = 0;
												 [animal moveOrigin:CGPointMake(100, 0)];
                                                 [AudioController playCheer];
											 } completion:^(BOOL finished){
												 if (!finished) 
													 return;
												 
											 }] ;
										 }] ;
									 }] ;
								 }] ;
							 }] ;
						 }];
						 
					 }];
	
}

@end
