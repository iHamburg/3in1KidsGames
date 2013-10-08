//
//  XCShapePlayView.m
//  KidsLearn
//
//  Created by  on 19.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "XCShapePlayView.h"

@implementation XCShapePlayView

//@synthesize vc;
- (void)load{
	[super load];
	
	bgV.image = [UIImage imageNamed:@"View_NCS_S_Learn_BG.png"];

    testIcon = [Sprite spriteWithNames:[NSArray arrayWithObjects:@"playBtn_1.png",@"playBtn_2.png" ,nil]];
    testIcon.delegate = self;
    [testIcon setOrigin:CGPointMake(800, 50)];
    testIcon.animationDuration = 0.5;
    testIcon.animationRepeatCount = 0;
	
    [self addSubview:testIcon];
}

- (void)setup{
	[super setup];
}

- (void)play{
    isLeft = NO;
    [AudioController playShape:selectedIndex delegate:nil];

}

//- (IBAction)buttonClicked:(id)sender{
//    L();
//    // vc add testV
//    isLeft = YES;
//    [vc toTest:selectedIndex];
//}

- (void)spriteDidClicked:(Sprite *)sprite{
    if (sprite == testIcon) {
        
        isLeft = YES;
        [vc toTest:selectedIndex];
    }
}
@end
