//
//  XCShapeTestView.h
//  KidsLearn
//
//  Created by  on 19.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "XCTestView.h"

@interface XCShapeTestView : XCTestView{
	Sprite *correctSprite;
	Sprite *wrong1;
	Sprite *wrong2;
	NSMutableArray *testSprites;
	NSArray *testImageNames;
	
	int correctIndex; //0-2
	BOOL isEnding;

}

@end
