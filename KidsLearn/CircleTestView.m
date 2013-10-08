//
//  CircleTestView.m
//  KidsLearn
//
//  Created by  on 25.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "CircleTestView.h"

@implementation CircleTestView

- (void)load{
//	L();
	[super load];
	waffe = [Sprite spriteWithName:@"Ice_base.png"];
	[waffe setOrigin:CGPointMake(435, 300)];
		
    waffe.delegate = self;
    ball1 = [Sprite spriteWithName:@"ice_pink.png" origin:CGPointMake(231, 222)];
	ball1.alpha = 0;
    ball1.delegate = self;
	ball2 = [Sprite spriteWithName:@"ice_yellow.png" origin:CGPointMake(695, 222)];
	ball2.alpha = 0;
    ball2.delegate = self;
	ball3 = [Sprite spriteWithName:@"ice_brown.png" origin:CGPointMake(473, 76)];
	ball3.alpha = 0;
    ball3.delegate = self;
	
    [self addSubview:ball3];
	[self addSubview:ball1];
	[self addSubview:ball2];
    
    [self addSubview:waffe];
	

}

// circle_comp1 is correct
- (void)setup{
	L();
	[super setup];
	
}



#pragma mark -
- (void)startCorrectAnimating{
	
	[super startCorrectAnimating];
	
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
								 if (!finished) {
									 return;
								 }
								 [UIView animateWithDuration:1 animations:^(void){
									 [ball1 setOrigin:CGPointMake(431, 222)];
									 [ball2 setOrigin:CGPointMake(495, 222)];
									 [ball3 setOrigin:CGPointMake(473, 176)];
									 
								 }] ;
							 }] ;
						 }];
						 
					 }];

}

- (void)startWrongAnimating{
	

	[super startWrongAnimating];

	[AnimationiManager waver:waffe];
}

#pragma mark - Sprite

- (void)spriteDidClicked:(Sprite *)sprite{
    
    [super spriteDidClicked:sprite];
    
    if (isEnding && (sprite == waffe ||sprite == ball1 || sprite == ball2 || sprite == ball3)) {
        [AudioController playItemButton];

        [AnimationiManager jumps:[NSArray arrayWithObjects:waffe,ball1,ball2,ball3, nil]];
        
    }
}
@end
