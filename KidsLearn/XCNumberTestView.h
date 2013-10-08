//
//  XCNumberTestView.h
//  KidsLearn
//
//  Created by  on 19.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "XCTestView.h"

// bgv -> giraffes -> controlV

/*
 Animation: 
 
 giraffes eats bananas(i): giraffes moves and the banana disappear
 
 */ 

@interface XCNumberTestView : XCTestView<GestureDelegate>{

	Sprite *giraffes;
	CGRect eatRect;
	
	int testCount; // 0 - 9 ->1-10 banana
	int eatenBananaCount;   //0 - 10 
	int selectedBananaIndex;  // 0-9
}


- (void)giraffesEat:(id)banana;
- (void)reset;
@end
