//
//  XCShapeTestView.m
//  KidsLearn
//
//  Created by  on 19.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "XCShapeTestView.h"

@implementation XCShapeTestView

- (void)load{
	[super load];
	
    bgV.image = [UIImage imageNamed:@"View_NCS_S_Learn_BG.png"];
    
	Sprite* test1 = [Sprite spriteWithOrigin:CGPointMake(830, 170)];
	test1.delegate = self;
	Sprite* test2 = [Sprite spriteWithOrigin:CGPointMake(830, 300)];
	test2.delegate = self;
	Sprite* test3 = [Sprite spriteWithOrigin:CGPointMake(830, 430)];
	test3.delegate = self;
	testSprites = [NSMutableArray arrayWithObjects:test1,test2,test3, nil];
	

	[self addSubview:test1];
	[self addSubview:test2];
	[self addSubview:test3];
	
	
	isEnding = NO;

}

- (void)setup{
	[super setup];
	
	correctIndex = arc4random()%3;
	
	// first object is the correct image
	testImageNames = [SpriteManager imgNamesInShapeTestWithIndex:selectedIndex];
	
	//
	correctSprite = [testSprites objectAtIndex:correctIndex];
	correctSprite.image = [UIImage imageNamed:[testImageNames objectAtIndex:0]];
    correctSprite.contentMode = UIViewContentModeCenter;
    [correctSprite setSize:CGSizeMake(130, 130)];
	[testSprites removeObject:correctSprite];
	
	// only 2 sprite in the array
	wrong1 = [testSprites objectAtIndex:arc4random()%2];
	wrong1.image = [UIImage imageNamed:[testImageNames objectAtIndex:1]];
    wrong1.contentMode = UIViewContentModeCenter;
	[wrong1 setSize:CGSizeMake(130, 130)];
    [testSprites removeObject:wrong1];
    
	
	//only 1sprite in the array;
	
	wrong2 = [testSprites objectAtIndex:0];
	wrong2.image = [UIImage imageNamed:[testImageNames objectAtIndex:2]];
    wrong2.contentMode = UIViewContentModeCenter;
    [wrong2 setSize:CGSizeMake(130, 130)];
	[testSprites removeObject:wrong2];
	
	
	[AudioController playShape:selectedIndex delegate:nil];
	
	[AnimationiManager scale:correctSprite withScale:0.8 times:2];
	[AnimationiManager scale:wrong1 withScale:0.8 times:2];
	[AnimationiManager scale:wrong2 withScale:0.8 times:2];
}

- (void)startCorrectAnimating{
	isEnding = YES;
	[AudioController playAudio:AudioCheer delegate:nil];
	[AudioController playShape:selectedIndex delegate:nil];

}
- (void)startWrongAnimating{
	[AudioController playAudio:AudioWrong delegate:nil];

}

#pragma mark - Sprite
- (void)spriteDidClicked:(Sprite *)sprite{
    
    // control compoment animation
    if(sprite == wrong1 || sprite == wrong2||sprite == correctSprite){
        if (isEnding) {
            [AnimationiManager scale:sprite withScale:1.2 times:2];
            if (sprite == correctSprite) {
                [AudioController playShape:selectedIndex delegate:nil];
            }
            else {
                [AudioController playWrongButton];
            }
           
        }
        else {
            if (sprite == correctSprite) {
                [self startCorrectAnimating];
            }
            else {
                
                [self startWrongAnimating];
                
            }
        }
        

    return;
    }
}
@end
