//
//  XCNumberBallonPlayView.m
//  KidsLearn
//
//  Created by  on 05.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "XCNumberBallonPlayView.h"

@implementation XCNumberBallonPlayView

- (void)load{
	[super load];
	
	
	for (int i = 0; i<10; i++) {

		Sprite *ballon = [Sprite spriteWithName:[ballonNames objectAtIndex:arc4random()%3]];
			
		[sprites addObject:ballon];
		[self insertSubview:ballon belowSubview:vorderLayer];
	}
}

- (void)setup{
	[super setup];
	// reset all bullons to original place;
	for (int i = 0; i<10; i++) {
		Sprite *sprite = [sprites objectAtIndex:i];
		// reset img
		
		sprite.image = [UIImage imageNamed:[ballonNames objectAtIndex:arc4random()%3]];
		
		// reset location, selectedIndex:0 - 9 -> 1-10 ballons, 
		CGFloat xMargin = size.width/(selectedIndex+2);
		
		[sprite setOrigin:CGPointMake(xMargin+i*xMargin, 300+arc4random()%10)];
		sprite.hidden = YES;
		
	}
	
	for (int i = 0; i<selectedIndex+1; i++) {
		[[sprites objectAtIndex:i] setHidden:NO];
	}
}

- (void)play{
	L();
	[UIView animateWithDuration:5.0
	 
						  delay: 0.0
	 
						options: UIViewAnimationOptionCurveEaseIn
	 
					 animations:^{
						 
						 for (Sprite *sprite in sprites) {
							 [sprite moveOrigin:CGPointMake(0, -300)];
						 }
						 
					 }
	 
					 completion:^(BOOL finished){
						 
						 
						 
					 }];

	
}
@end
