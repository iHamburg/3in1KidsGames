//
//  XCColorPlayView.m
//  KidsLearn
//
//  Created by  on 19.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "XCColorPlayView.h"

@implementation XCColorPlayView

- (void)load{
	[super load];
	
	bgV.image = [UIImage imageNamed:@"View_NCS_C_Learn_BG.png"];
	
	indexButton = [UIButton buttonWithFrame:CGRectMake(460, 50, 106, 121) title:nil image:nil target:self action:@selector(buttonClicked:)];
	originImages = [NSMutableArray array];
	bwImages = [NSMutableArray array];
	
	
	[self addSubview:indexButton];
}

- (void)setup{
	
	[indexButton setBackgroundImage:[SpriteManager colorImgWithIndex:selectedIndex] forState:UIControlStateNormal];
	
	
	for (Sprite *sprite in sprites) {
		[sprite removeFromSuperview];
		
	}
	[sprites removeAllObjects];
	
	//因为每次的index所产生的sprites都不一样
	NSArray *spriteNames = [SpriteManager colorSpriteNamesWithIndex:selectedIndex];
//	rect: 270,300,500,380
	for (int i = 0; i<[spriteNames count]; i++) {
		Sprite *sprite = [Sprite spriteWithName:[spriteNames objectAtIndex:i]];
		sprite.delegate = self;
		[sprite setSize:CGSizeMake(250, 150)];
		sprite.contentMode = UIViewContentModeCenter;
		[sprites addObject:sprite];

	}
	
	playSprites = [sprites arrayWithRandom:4];
	[originImages removeAllObjects];
	[bwImages removeAllObjects];
	
	for (int i = 0; i<[playSprites count]; i++) {
		Sprite *sprite = [playSprites objectAtIndex:i];
		[originImages addObject:sprite.image];
		UIImage *bwImg = [[Controller sharedInstance]makeImageBW:sprite.image];
		[bwImages addObject:bwImg];
        NSLog(@"bwImage.size:%@", NSStringFromCGSize(bwImg.size));
		sprite.image = bwImg;
		sprite.frame = CGRectMake(270+250*(i%2), 300+150*(i/2), 250,150);
//        sprite.backgroundColor = [UIColor redColor];
        
//        if (MAX(bwImg.size.width, bwImg.size.height)>150) {
//            NSLog(@"aspect fit");
//            sprite.contentMode = UIViewContentModeScaleAspectFit;
//        }
//        else {
//            sprite.contentMode = UIViewContentModeCenter;
//        }

		 sprite.contentMode = UIViewContentModeCenter;
		
		[self addSubview:sprite];
	}
    

}
#pragma mark - IBOutlet

//
- (IBAction)buttonClicked:(id)sender{
	[AudioController playColor:selectedIndex delegate:nil];
}

#pragma mark - Sprite
- (void)spriteDidClicked:(Sprite *)sprite{
	int index = [playSprites indexOfObject:sprite];
	[AudioController playColor:selectedIndex delegate:nil];
	[AnimationiManager scale:sprite withScale:1.5 times:1];
    
	sprite.image = [originImages objectAtIndex:index];
	sprite.contentMode = UIViewContentModeCenter;
	sprite.frame = CGRectMake(270+250*(index%2), 300+150*(index/2), 250,150);
    
//	sprite.contentMode = UIViewContentModeCenter;
}




@end
