//
//  CirclePlayView.h
//  KidsLearn
//
//  Created by  on 25.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "XCShapePlayView.h"

@interface CirclePlayView : XCShapePlayView{
	Sprite *waffe;
	
	Sprite *ball1; // endlocation:431,222
	Sprite *ball2; //             495,222
	Sprite *ball3;//              473,176
	

	void (^block1)(void);
	void (^a1Finished)(BOOL finished);
	
}

- (void)actionAlpha:(float)endAlpha;
@end
