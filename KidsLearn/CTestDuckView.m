//
//  CTestDuckView.m
//  KidsLearn
//
//  Created by  on 24.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "CTestDuckView.h"

@implementation CTestDuckView

@synthesize colorIndex;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

		
		duck = [Sprite spriteWithNames:[NSArray arrayWithObjects:@"duck0.png",@"duck1.png" ,nil]];
		[duck setOrigin:CGPointMake(230,35)];
		duck.animationDuration = 1;
		duck.animationRepeatCount = 1;
        duck.delegate = self;
		
		bubble = [Sprite spriteWithName:@"bubble.png"];
			
		colorCan = [Sprite spriteWithName:@"colorblue.png"];
		colorCan.frame = CGRectMake(80, 0, 59, 68);
		
		[self addSubview:duck];
		[self addSubview:bubble];
		[self addSubview:colorCan];
		
		
    }
    return self;
}

- (void)setup{
	bubble.hidden = YES;
	colorCan.hidden = YES;
	colorCan.image = [SpriteManager colorCanImgWithIndex:colorIndex];
	colorCan.frame = CGRectMake(80, 0, 59, 68);
//	duck = [Sprite spriteWithNames:[NSArray arrayWithObjects:@"duck0.png",@"duck1.png" ,nil]];
}


- (void)setColorIndex:(int)_colorIndex{
	colorIndex = _colorIndex;
	[self setup];
}

- (void)startAnimation{

	bubble.hidden = NO;
	colorCan.hidden = NO;
	[duck startAnimating];
}
- (void)stopAnimation{
	
}

#pragma mark - Sprite
- (void)spriteDidClicked:(Sprite *)sprite{
    
    if (sprite == duck) {
        [duck startAnimating];
        [AudioController playColor:colorIndex delegate:nil];
    }
}
@end
