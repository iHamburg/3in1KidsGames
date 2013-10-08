//
//  RectangleTestView.m
//  KidsLearn
//
//  Created by  on 25.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "RectangleTestView.h"

@implementation RectangleTestView



- (void)load{
	//	L();
	[super load];

	photoFrame = [Sprite spriteWithName:@"photo_frame_trans.png" origin:CGPointMake(300, 220)];
	photoFrame.delegate = self;
	
	NSArray *giraffesNames = [NSArray arrayWithObjects:@"rectangle_giraffes_animation_0.png", @"rectangle_giraffes_animation_1.png", 
							  @"rectangle_giraffes_animation_2.png", @"rectangle_giraffes_animation_3.png", nil];
	
	giraffes = [Sprite spriteWithNames:giraffesNames];
	giraffes.delegate = self;
	[giraffes setOrigin:CGPointMake(490, 70)];
	
	[self addSubview:giraffes];
	[self addSubview:photoFrame];
	
}



- (void)setup{
	L();
	[super setup];
	
}



#pragma mark -
- (void)startCorrectAnimating{
	
	[super startCorrectAnimating];
	
	
	
	[UIView animateWithDuration:5 
					 animations:^(void){ // giraffes move
						 [giraffes startAnimating];
						 [giraffes moveOrigin:CGPointMake(-450, 0)];
					 }
					 completion:^(BOOL finished){
						 if (!finished) 
							 return;
						
						 [giraffes stopAnimating];
					 }];
	
}

- (void)startWrongAnimating{
	
	
	[super startWrongAnimating];
	
	
	[AnimationiManager waver:photoFrame];
	
}


#pragma mark - Sprite
- (void)spriteDidClicked:(Sprite *)sprite{
    [super spriteDidClicked:sprite];
    
    if(!isEnding){
        return;
    }
    
    [AudioController playItemButton];
    
    if (sprite == photoFrame) {
		[AnimationiManager rotate:sprite];
    }
    else if(sprite == giraffes){
		[AnimationiManager jump:giraffes];
    }
}

@end
