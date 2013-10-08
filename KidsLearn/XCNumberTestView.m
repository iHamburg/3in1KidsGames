//
//  XCNumberTestView.m
//  KidsLearn
//
//  Created by  on 19.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "XCNumberTestView.h"

@implementation XCNumberTestView


- (void)load{
	
	[super load];
	
	self.autoresizingMask = kAutoResize;
	
    bgV.image = [UIImage imageNamed:@"BG_DisplayResult.png"];
	eatRect = CGRectMake(310, 272, 150 , 150);
	
	
	giraffes = [Sprite spriteWithName:@"Giraffes.png"];
	[giraffes setOrigin:CGPointMake(350, 200)];
	giraffes.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"Giraffes.png"],[UIImage imageNamed:@"Giraffes2.png"], nil];
	giraffes.animationRepeatCount = 1; 
    giraffes.animationDuration = 0.5;
	giraffes.delegate = self;
	giraffes.autoresizingMask = kAutoResize;
    
	[self insertSubview:giraffes aboveSubview:controlV];
	
	for (int i = 0; i<10; i++) {
		
		Sprite *banana = [Sprite spriteWithName:@"banana.png"];
		[sprites addObject:banana];
		[controlV addGestureRecognizersToPiece:banana];
		[controlV addSubview:banana];
		banana.autoresizingMask = kAutoResize;
	}

}

- (void)setup{
	L();
	[super setup];
	
    //predefined:testNumberIndex
    
	eatenBananaCount = -1;
	
	[AudioController playNumber:testNumberIndex delegate:nil];
	// reset banana
	CGFloat xMargin = size.width/([sprites count]+1);
	UIImage *foodImg = [[Controller sharedInstance] foodImageForNumberTest];

	for (int i = 0; i<[sprites count]; i++) {
		Sprite *banana = [sprites objectAtIndex:i];
        banana.image = foodImg;
		[banana setOrigin:CGPointMake(xMargin*(i+1), 50)];
		banana.hidden = NO;
	}
	
    NSLog(@"sprites:%@",sprites);
	
}

- (void)setTestNumberIndex:(int)_testNumberIndex{
    testNumberIndex = _testNumberIndex;
    
    [self setup];
}

- (void)reset{
      [[UIApplication sharedApplication]endIgnoringInteractionEvents];
    self.testNumberIndex = arc4random()%10;

    
    
}
#pragma mark - Animation
//giraffes eats bananas(i): giraffes moves and the banana disappear

- (void)giraffesEat:(Sprite*)banana{
	L();

	// if banana is already hidden
	if (banana.hidden) {
		return;
	}
	
	banana.hidden = YES;
	eatenBananaCount++;
//    [AudioController playEating];
	[[AudioController sharedInstance]playSound:AudioEating];
	
	[giraffes startAnimating];
	
	NSLog(@"eaten:%d,test:%d",eatenBananaCount, testNumberIndex);
	if (eatenBananaCount == testNumberIndex) {

        [[UIApplication sharedApplication]beginIgnoringInteractionEvents];
        [AudioController playCheer];
        [self performSelector:@selector(reset) withObject:nil afterDelay:2];
	}
}

#pragma mark - ControlGesture
- (void)willPanPiece:(UIPanGestureRecognizer *)gestureRecognizer inView:(UIView *)controllView{
	UIView *piece = [gestureRecognizer view];
	CGPoint point = [gestureRecognizer locationInView:self];

	
//	NSLog(@"selected:%d,point:%@",selectedBananaIndex,NSStringFromCGPoint(point));
	if (CGRectContainsPoint(eatRect, point)) {

		[self giraffesEat:piece];
		
	}
}

#pragma mark - Sprite
- (void)spriteDidClicked:(Sprite *)sprite{
	if (sprite == giraffes) {
		[AudioController playNumber:testNumberIndex delegate:nil];
		[AnimationiManager rotate:giraffes];
	}
}
@end
