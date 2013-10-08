//
//  RectanglePlayView.m
//  KidsLearn
//
//  Created by  on 25.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "RectanglePlayView.h"

@implementation RectanglePlayView

- (void)load{
	[super load];
	
	photoFrame = [Sprite spriteWithName:@"photo_frame_trans.png" origin:CGPointMake(300, 220)];
	
	NSArray *giraffesNames = [NSArray arrayWithObjects:@"rectangle_giraffes_animation_0.png", @"rectangle_giraffes_animation_1.png", 
							  @"rectangle_giraffes_animation_2.png", @"rectangle_giraffes_animation_3.png", nil];
	
	giraffes = [Sprite spriteWithNames:giraffesNames];
	
	[giraffes setOrigin:CGPointMake(690, 70)];
	
	[self addSubview:giraffes];
	[self addSubview:photoFrame];
	
}

- (void)play{
//	[AudioController playShape:shapeRectangle delegate:nil];
	
    [super play];
    
	[UIView animateWithDuration:5 
					 animations:^(void){ // giraffes move
						 [giraffes startAnimating];
						 [giraffes moveOrigin:CGPointMake(-650, 0)];
//                         [AudioController playGiraffMove];
					 }
					 completion:^(BOOL finished){
						 if (isLeft) 
							 return;
						 [AudioController playShape:shapeRectangle delegate:nil];
						 [giraffes stopAnimating];
					 }];

}

@end
