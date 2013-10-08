//
//  SquareTestView.m
//  KidsLearn
//
//  Created by  on 25.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "SquareTestView.h"

@implementation SquareTestView


- (void)load{
	//	L();
	[super load];

	clock = [Sprite spriteWithNames:[NSArray arrayWithObjects:@"square_clock0.png",@"square_clock1.png",
									@"square_clock2.png",@"square_clock3.png", nil]];
	[clock setOrigin:CGPointMake(250, 190)];
	clock.animationRepeatCount = 1;
	clock.delegate = self;
	[self addSubview:clock];
}



- (void)setup{
	L();
	
    [super setup];
	
}



#pragma mark -
- (void)startCorrectAnimating{
	
	[super startCorrectAnimating];

	clock.image = [clock.animationImages lastObject];
    [AudioController playSSDida];
	[clock startAnimating];
	
}

- (void)startWrongAnimating{
	
	
	[super startWrongAnimating];
	
	[AnimationiManager waver:clock];
	
}


#pragma mark - Sprite
- (void)spriteDidClicked:(Sprite *)sprite{
    [super spriteDidClicked:sprite];
    
    if(!isEnding){
        return;
    }
    
    [AudioController playItemButton];
    
    if (sprite == clock) {
		[AnimationiManager rotate:sprite];
    }
   
}


@end
