//
//  PentagonTestView.m
//  KidsLearn
//
//  Created by  on 25.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "PentagonTestView.h"

@implementation PentagonTestView



- (void)load{
	//	L();
	[super load];
	

	rabbit1 = [Sprite spriteWithNames:[NSArray arrayWithObjects:@"pentagon_rabbitAnimation0.png",@"pentagon_rabbitAnimation1.png",@"pentagon_rabbitAnimation2.png", nil]];
	[rabbit1 setOrigin:CGPointMake(430, 365)];
	
	rabbit2 =  [Sprite spriteWithName:@"pentagon_rabbit.png" origin:CGPointMake(430, 365)];
	rabbit2.alpha = 0;
    rabbit2.delegate = self;
	
	house = [Sprite spriteWithName:@"pentagon_house.png" origin:CGPointMake(311, 220)];
	house.transform = CGAffineTransformMakeScale(0.5, 0.5);
	house.alpha = 0;
    house.delegate = self;
	
	[self addSubview:rabbit1];
	[self addSubview:rabbit2];
	[self addSubview:house];
	
}



- (void)setup{
	L();
	[super setup];
	
	[rabbit1 startAnimating];
}



#pragma mark -
- (void)startCorrectAnimating{
	
	[super startCorrectAnimating];
	
	rabbit1.alpha = 0;
	house.alpha = 1;
	
	[UIView animateWithDuration:1 animations:^{
		house.transform = CGAffineTransformMakeScale(1, 1);
	} completion:^(BOOL finished) {
		rabbit2.alpha = 1;
		[UIView animateWithDuration:1 animations:^{
			[rabbit2 moveOrigin:CGPointMake(100, 0)];
		} completion:nil];
	}];

	
}

- (void)startWrongAnimating{
	
	
	[super startWrongAnimating];
	
	
	[AnimationiManager waver:rabbit1];
	
}



#pragma mark - Sprite
- (void)spriteDidClicked:(Sprite *)sprite{
    [super spriteDidClicked:sprite];
    
    if(!isEnding){
        return;
    }
    
    [AudioController playItemButton];
    
    if (sprite == rabbit2) {
           [UIView animateWithDuration:0.5 animations:^{
               [rabbit2 moveOrigin:CGPointMake(-100, 0)];
//               [rabbit2 setAlpha:0];
           }];
    }
    else if(sprite == house){

        if (rabbit2.frame.origin.x <500) {
            [UIView animateWithDuration:0.5 animations:^{
                [rabbit2 moveOrigin:CGPointMake(100, 0)];
//                [rabbit2 setAlpha:1];
            }];
        }
    }
}

@end
