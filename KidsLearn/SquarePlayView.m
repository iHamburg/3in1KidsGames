//
//  SquarePlayView.m
//  KidsLearn
//
//  Created by  on 25.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "SquarePlayView.h"

@implementation SquarePlayView

- (void)load{
	[super load];
	
	box1 = [Sprite spriteWithName:@"block_blue.png" origin:CGPointMake(220, 270)];
	
	box2 = [Sprite spriteWithName:@"block_green.png" origin:CGPointMake(415, 270)]; //605
	
	box3 = [Sprite spriteWithName:@"block_orange.png" origin:CGPointMake(605, 270)];
	
	rabbit = [Sprite spriteWithName:@"square_rabbit.png" origin:CGPointMake(415, 270)];
	rabbit.alpha = 0;
	
	[self addSubview:rabbit];
	[self addSubview:box1];
	[self addSubview:box3];
    [self addSubview:box2];
}

- (void)play{
		
    [super play];
	[UIView animateWithDuration:0.5 
					 animations:^(void){ // box2 变大
						 box2.transform = CGAffineTransformMakeScale(1.5, 1.5);
					 }
					 completion:^(BOOL finished){
						 if (!finished) 
							 return;
						 
						 [UIView animateWithDuration:0.5 animations:^(void){ // box2 缩小
							 box2.transform = CGAffineTransformMakeScale(1.0, 1.0);
						 }completion:^(BOOL finished){
							 if (!finished) 
								 return;					
							 [UIView animateWithDuration:0.5 animations:^(void){ // box2 放大
								 box2.transform = CGAffineTransformMakeScale(1.5, 1.5);
							 }completion:^(BOOL finished){

								 if (!finished) 
									 return;					
								 [UIView animateWithDuration:0.5 animations:^(void){ // box2 缩小
									 box2.transform = CGAffineTransformMakeScale(1.0, 1.0);
								 }completion:^(BOOL finished){
//                                      NSLog(@"finished:%d",finished);
									 if (!finished) 
										 return;					
									 rabbit.alpha = 1;
									 [UIView animateWithDuration:0.5 animations:^(void){ // rabbit 出现
										 [rabbit moveOrigin:CGPointMake(0, -125)];
									 }completion:^(BOOL finished){
                                         
                                         NSLog(@"isleft:%d",isLeft);
                                         
										 if (isLeft) 
											 return;					
                                        [AudioController playCheer];
									 }];
								 }];
							 }];
						 }];
					 }];

}

@end
