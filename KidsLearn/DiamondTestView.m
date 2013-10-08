//
//  DiamondTestView.m
//  KidsLearn
//
//  Created by  on 25.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "DiamondTestView.h"

@implementation DiamondTestView



- (void)load{
	//	L();
	[super load];
	
	building = [Sprite spriteWithName:@"diamond_building.png" origin:CGPointMake(380, 140)];
//	building.transform = CGAffineTransformMakeScale(0.5, 0.5);
	
	diamond = [Sprite spriteWithName:@"diamond.png" origin:CGPointMake(800, 100)];
	diamond.alpha = 0;
    diamond.delegate = self;
	
	animal = [Sprite spriteWithNames:[NSArray arrayWithObjects:@"diamond_animation_tiger0.png",@"diamond_animation_tiger1.png", nil]];
	[animal setOrigin:CGPointMake(220, 360)];
	animal.animationDuration = 1;
	animal.animationRepeatCount = 1;
    animal.delegate = self;
	
	[self addSubview:animal];
	[self addSubview:building];
	[self addSubview:diamond];
	
}



- (void)setup{
//	L();
	[super setup];
	
    //set diamond location to correct
    [diamond setOrigin:correctSprite.frame.origin];
}



#pragma mark -
- (void)startCorrectAnimating{
	
	[super startCorrectAnimating];
	diamond.alpha = 1;
	[UIView animateWithDuration:2 animations:^(void){ //diamond 旋转到位移到435，300
		diamond.transform = CGAffineTransformMakeRotation(M_PI);
		[diamond setOrigin:CGPointMake(437, 292)];
	}completion:^(BOOL finished){

	}];

	[UIView animateWithDuration:0.5 animations:^{
		[animal startAnimating];
		[animal moveOrigin:CGPointMake(0, -100)];
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:0.5 animations:^{
			[animal moveOrigin:CGPointMake(0, 100)];
		}];
	}];
	
	
}

- (void)startWrongAnimating{
	
	
	[super startWrongAnimating];
	
	
	[AnimationiManager waver:building];
	
}

#pragma mark - Sprite
- (void)spriteDidClicked:(Sprite *)sprite{
    [super spriteDidClicked:sprite];
    
    if(!isEnding){
        return;
    }
    
    [AudioController playItemButton];
    
    if (sprite == animal) {
        [UIView animateWithDuration:0.5 animations:^{
            [animal startAnimating];
            [animal moveOrigin:CGPointMake(0, -100)];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                [animal moveOrigin:CGPointMake(0, 100)];
            }];
        }];
    }
    else if(sprite == diamond){
        [UIView animateWithDuration:1 animations:^{
            diamond.transform = CGAffineTransformRotate(diamond.transform, 1.5*M_PI);

        }];
    }
}
@end
