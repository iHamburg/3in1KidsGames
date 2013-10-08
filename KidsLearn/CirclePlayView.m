//
//  CirclePlayView.m
//  KidsLearn
//
//  Created by  on 25.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "CirclePlayView.h"

@implementation CirclePlayView

- (void)load{
	[super load];
	
	waffe = [Sprite spriteWithName:@"Ice_base.png"];
	[waffe setOrigin:CGPointMake(435, 310)];
	waffe.transform = CGAffineTransformMakeScale(0.5, 0.5);
	
	ball1 = [Sprite spriteWithName:@"ice_pink.png" origin:CGPointMake(231, 222)];
	ball1.alpha = 0;
	ball2 = [Sprite spriteWithName:@"ice_yellow.png" origin:CGPointMake(695, 222)];
	ball2.alpha = 0;
	ball3 = [Sprite spriteWithName:@"ice_brown.png" origin:CGPointMake(473, 76)];
	ball3.alpha = 0;
	
    [self addSubview:ball3];
	[self addSubview:ball1];
	[self addSubview:ball2];

    [self addSubview:waffe];
	
//	block1 = ^(void){
//		ball1.alpha = 1;
//		
//	};
	

}

- (void)setup{
	[super setup];
}

- (void)play{
	L();
	// show b1 and then b2 and then b3
	[super play];
    
	[UIView animateWithDuration:0.5 
					 animations:^(void){
						 ball1.alpha = 1;
					 }
					 completion:^(BOOL finished){
						 if (!finished) {
							 return;
						 }
						 [UIView animateWithDuration:0.5 animations:^(void){
							 ball2.alpha = 1;
						 }completion:^(BOOL finished){
							 if (!finished) {
								 return;
							 }
							 [UIView animateWithDuration:0.5 animations:^(void){
								 ball3.alpha = 1;
								
							 } completion:^(BOOL finished){
								 if (isLeft) {
									 return;
								 }
                                 
                                 
								 [UIView animateWithDuration:1 animations:^(void){
                                     
                                      waffe.transform = CGAffineTransformMakeScale(1, 1);
									 [ball1 setOrigin:CGPointMake(431, 222)];
									  [ball2 setOrigin:CGPointMake(495, 222)];
									  [ball3 setOrigin:CGPointMake(473, 176)];
									 
                                     [AudioController playCheer];
								 }] ;
							 }] ;
						 }];
						 
					 }];
	
}

- (void)actionAlpha:(float)endAlpha{
	[UIView animateWithDuration:1 
			animations:^(void){
		
						 
	}
			completion:^(BOOL finished){
						 
					 
				}];
}
@end
