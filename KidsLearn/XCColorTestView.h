//
//  XCColorTestView.h
//  KidsLearn
//
//  Created by  on 19.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "XCTestView.h"
#import "CTestDuckView.h"


@interface XCColorTestView : XCTestView{

	CTestDuckView *duckV;
	
	int rightNumber; //0 or 1
	int anotherIndex;

	Sprite *leftSprite;
	Sprite *rightSprite;
}


@end
