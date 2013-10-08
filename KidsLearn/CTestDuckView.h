//
//  CTestDuckView.h
//  KidsLearn
//
//  Created by  on 24.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Controller.h"
#import "Sprite.h"


//size: 420,180

@interface CTestDuckView : UIView<SpriteDelegate>{
	Sprite *duck; //origin:230,35
	Sprite *bubble; //0,0
	Sprite *colorCan; //80,0

	int colorIndex;
}

@property (nonatomic, assign) int colorIndex;

- (void)setup;

- (void)startAnimation;
- (void)stopAnimation;
@end
