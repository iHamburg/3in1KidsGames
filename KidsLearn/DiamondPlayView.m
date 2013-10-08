//
//  DiamondPlayView.m
//  KidsLearn
//
//  Created by  on 25.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "DiamondPlayView.h"

@implementation DiamondPlayView

- (void)load{
	[super load];
	
	building = [Sprite spriteWithName:@"diamond_building.png" origin:CGPointMake(380, 140)];
	building.transform = CGAffineTransformMakeScale(0.5, 0.5);

	diamond = [Sprite spriteWithName:@"diamond.png" origin:CGPointMake(800, 100)];
	diamond.alpha = 0;
	
	animal = [Sprite spriteWithName:@"diamond_hedgehog" origin:CGPointMake(420, 400)];
	animal.alpha = 0;
	
	[self addSubview:animal];
	[self addSubview:building];
	[self addSubview:diamond];
}

- (void)play{
    
    [super play];
    
	[UIView animateWithDuration:0.5 
					 animations:^(void){ // build 变大， diamond出现
						 building.transform = CGAffineTransformMakeScale(1, 1);
						 diamond.alpha = 1;
					 }
					 completion:^(BOOL finished){
						 if (!finished) {
							 return;
						 }
						 [UIView animateWithDuration:2 animations:^(void){ //diamond 旋转到位移到435，300
							 diamond.transform = CGAffineTransformMakeRotation(M_PI);
							 [diamond setOrigin:CGPointMake(437, 292)];
						 }completion:^(BOOL finished){
							 if (isLeft) {
								 return;
							 }
							 animal.alpha = 1;
							 [UIView animateWithDuration:0.5 animations:^(void){ // animal show
								 [animal moveOrigin:CGPointMake(-120, 0)];
                                 [AudioController playShape:selectedIndex delegate:nil];
							 } completion:^(BOOL finished){
								 if (!finished) {
									 return;
								 }
							}] ;
						 }];
						 
					 }];
	

}
@end
