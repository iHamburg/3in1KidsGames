//
//  XCColorTestView.m
//  KidsLearn
//
//  Created by  on 19.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "XCColorTestView.h"

@implementation XCColorTestView

- (void)load{
	[super load];
	
	bgV.image = [UIImage imageNamed:@"View_NCS_C_Learn_BG.png"];
//	bgV.image = [[Controller sharedInstance]makeImageBW:[UIImage imageNamed:@"View_NCS_C_Learn_BG.png"]];

	duckV = [[CTestDuckView alloc]initWithFrame:CGRectMake(200, 0, 420, 180)];
	
	// add 2 sprites ,add delegate
	leftSprite = [[Sprite alloc]initWithFrame:CGRectMake(300, 360, 200, 200)];
	leftSprite.delegate = self;
    leftSprite.contentMode = UIViewContentModeCenter;
	[self addSubview:leftSprite];

//    leftSprite.backgroundColor = [UIColor redColor];
	
	rightSprite = [[Sprite alloc]initWithFrame:CGRectMake(600, 360, 200, 200)];
	rightSprite.delegate = self;
    rightSprite.contentMode = UIViewContentModeCenter;
	[self addSubview:rightSprite];

//    rightSprite.backgroundColor = [UIColor blueColor];
	
	[self addSubview:duckV];
}

- (void)setup{
	[super setup];
	
	// predefined: testIndex
	
    anotherIndex = arc4random()%7;
	while (anotherIndex==testIndex) {
		anotherIndex = arc4random()%7;
	}
	
//    anotherIndex = 1;
	NSLog(@"test:%d,another:%d",testIndex,anotherIndex);
	
	rightNumber = arc4random()%2;
	
	duckV.colorIndex = testIndex;
    
	[duckV performSelector:@selector(startAnimation) withObject:nil afterDelay:0.5];
	
	//reset left and right Sprite

	if (rightNumber == 0) { // left is testIndex, 
		leftSprite.image = [SpriteManager colorImgRandomWithIndex:testIndex];
		rightSprite.image = [SpriteManager colorImgRandomWithIndex:anotherIndex];
		
	}
	else{
		rightSprite.image = [SpriteManager colorImgRandomWithIndex:testIndex];
		leftSprite.image = [SpriteManager colorImgRandomWithIndex:anotherIndex];
	}

    [leftSprite setSize:CGSizeMake(200, 200)];
    [rightSprite setSize:CGSizeMake(200, 200)];
    
    [AudioController playColor:testIndex delegate:nil];
}

- (void)setTestIndex:(int)_testIndex{
	testIndex = _testIndex;
	[self setup];
}

#pragma mark - Sprite
- (void)spriteDidClicked:(Sprite *)sprite{
	L();
	
	[AnimationiManager clickAnimation:sprite];
	if ((sprite == leftSprite && rightNumber == 0)||(sprite == rightSprite && rightNumber == 1)) {
		NSLog(@"right");

		[AudioController playCheer];
		
        testIndex = arc4random()%7;
        [self performSelector:@selector(setup) withObject:nil afterDelay:1];
	}
	else {
		NSLog(@"wrong");
		
		[AudioController playWrong];

		
//		[self setup];
	}
}


@end
