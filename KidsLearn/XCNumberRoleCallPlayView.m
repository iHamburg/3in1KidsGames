//
//  XCNumberRoleCallPlayView.m
//  KidsLearn
//
//  Created by  on 05.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "XCNumberRoleCallPlayView.h"

@implementation XCNumberRoleCallPlayView

//banana, hamburg, 茄子，草莓，蛋

static float originXs[] = {
	846,827,95,366,670,130,707,265,474,636
};

static float originYs[] ={
	175,330,515,70,520,73,235,335,563,400
};

static float spriteWidth = 150;

- (void)load{
	L();
	[super load];
	
	self.autoresizingMask = kAutoResize;
	
	bgV.image = [UIImage imageWithContentsOfFile:GetFullPath(@"View_NCS_N_Learn_new.jpg")];
	
	
	// 载入所有的item
	spriteNames = [SpriteManager spriteNamesForNumberRoleCallView];
	NSLog(@"spriteNames:%@",spriteNames);
	
	spriteRects = [NSMutableArray array];
	
	//count: 10
	for (int i = 0; i<[spriteNames count]; i++) {
		Sprite *sprite = [Sprite spriteWithName:[spriteNames objectAtIndex:i]];
        sprite.delegate = self;
		[sprites addObject:sprite];
		[sprite setSize:CGSizeMake(spriteWidth, spriteWidth)];
        [sprite setOrigin:CGPointMake(originXs[i], originYs[i])];
		[self addSubview:sprite];
		sprite.hidden = YES;
//        sprite.backgroundColor = [UIColor redColor];

	}
	
	for (int i = 0; i<10; i++) {
		CGRect rect = CGRectMake(originXs[i], originYs[i], spriteWidth, spriteWidth);
		[spriteRects addObject:[NSValue valueWithCGRect:rect]];
        
	}
	


}

- (void)setup{
	[super setup];
	
	for (Sprite *sprite in sprites) {
		sprite.hidden = YES;
	}
	
	// selectedIndex: 0-9
	NSLog(@"selectedIndex:%d",selectedIndex);
	
	// 从sprites中找index＋1个spriteIndex，再从0-9中找index＋1个locationIndex， 让sprite显示在正确的location


	playSprites = [sprites arrayWithRandom:selectedIndex+1];
	
//	NSLog(@"playSpreits:%@,sprietePlayRects:%@",playSprites,spritePlayRects);
	for (int i = 0; i<selectedIndex+1; i++) {
		Sprite *sprite = [playSprites objectAtIndex:i];

		sprite.hidden = NO;
        sprite.transform = CGAffineTransformMakeScale(0.01, 0.01);
	
	}
		
}

- (void)play{
//	L();



	for (int i = 0; i<selectedIndex+1; i++) {
		Sprite *sprite = [playSprites objectAtIndex:i];
//		sprite.backgroundColor = [UIColor redColor];
        [self performSelector:@selector(roleCall:) withObject:sprite afterDelay:1.5*i];
		
	}
    

}


- (void)roleCall:(Sprite*)sprite{
	L();
	int index = [playSprites indexOfObject:sprite];

	[AudioController playNumber:index delegate:nil];
	
//	NSLog(@"sprit)
	
	[AnimationiManager scale:sprite withScale:1.5 times:1];
    

}

- (void)roleCallwithInfo:(NSDictionary*)info{
	L();
	Sprite *sprite = [info objectForKey:@"sprite"];
	
	CABasicAnimation *transforAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
	transforAnimation.duration = 2.0f;
	sprite.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(180));

	[sprite.layer addAnimation:transforAnimation forKey:@"tran"];
	
}

- (void)jumpOut:(Sprite*)sprite{
	int index = [playSprites indexOfObject:sprite];
	[AudioController playNumber:index delegate:nil];

	UIBezierPath *path = [UIBezierPath bezierPath];

	
    [path moveToPoint:startPoint];
	

	[path addQuadCurveToPoint:CGPointMake(860,225) controlPoint:CGPointMake(449, 225)];
	
    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation.path = path.CGPath;
    moveAnimation.duration = 2.0f;
	moveAnimation.removedOnCompletion = NO;
    // Setting the rotation mode ensures Pacman's mouth is always forward.  This is a very convenient CA feature.
    moveAnimation.rotationMode = kCAAnimationRotateAuto;
	[sprite setOrigin:CGPointMake(860-75, 225-75)];
	
    
	[sprite.layer addAnimation:moveAnimation forKey:@"moveAnimation"];
}

#pragma mark - Sprite
- (void)spriteDidClicked:(Sprite *)sprite{
    int index = [playSprites indexOfObject:sprite];
    
	NSLog(@"sprite:%@",NSStringFromCGPoint(sprite.frame.origin));
    [AudioController playNumber:index delegate:nil];
	
    [AnimationiManager jump:sprite];
    
    
}
float DEGREES_TO_RADIANS(int degree){
	return degree*M_PI/180;
}
@end
