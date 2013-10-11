//
//  XCNumberPlayView.m
//  KidsLearn
//
//  Created by  on 19.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "XCNumberPlayView.h"

@implementation XCNumberPlayView


//@synthesize  selectedNumber;
- (void)load{
	[super load];
	

	
	infoDict = [[SpriteManager sharedInstance] infoDictWithKey:@"NLearn"];

	ballonNames = [NSArray arrayWithObjects:@"balloons_green.png",@"balloons_orange",@"balloons_violet.png", nil];

	bgV.image = nil;
	
	bgLayer = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1024, 600)];
	bgLayer.image = [UIImage imageNamed:@"View_NCS_N_Learn_sky.jpg"];
	bgLayer.autoresizingMask = kAutoResize;
	
	vorderLayer = [[UIImageView alloc]initWithFrame:CGRectMake(0, 558, 1024, 210)];
	vorderLayer.image = [UIImage imageNamed:@"green_fields.png"];
	vorderLayer.autoresizingMask = kAutoResize;
	
	indexButton = [UIButton buttonWithFrame:CGRectMake(500, 110, 143, 123) title:nil image:nil target:self action:@selector(buttonClicked:)];
	indexButton.autoresizingMask = kAutoResize;
	
    bearLayer = [Sprite spriteWithNames:[NSArray arrayWithObjects:@"animation_bear_1.png",@"animation_bear_2.png", nil]];
	[bearLayer setOrigin:CGPointMake(515, 5)];
    [bearLayer setSize:CGSizeMake(108, 111)];
    bearLayer.animationRepeatCount = 0;
    bearLayer.autoresizingMask = kAutoResize;

	ropeLayer = [Sprite spriteWithName:@"rope.png"];
	[ropeLayer setOrigin:CGPointMake(0, 190)];
	ropeLayer.autoresizingMask = kAutoResize;
	
	// 10个气球
	sprites = [NSMutableArray array];


	
	[self addSubview:indexButton];
    [self addSubview:bearLayer];
	[self addSubview:ropeLayer];

	
	
	
	selectedIndex = 9;
}
- (void)setup{
	
	// selectedIndex
	
	[super setup];

	
	[indexButton setBackgroundImage:[SpriteManager numberImgWithIndex:selectedIndex] forState:UIControlStateNormal];

}

#pragma mark -
- (IBAction)buttonClicked:(id)sender{
	L();
    [AudioController playNumber:selectedIndex delegate:nil];
}



#pragma mark - Animation
- (void)play{


}
@end
