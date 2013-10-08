//
//  XCTestView.h
//  KidsLearn
//
//  Created by  on 18.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Controller.h"
#import "XCLearnViewController.h"
#import "Sprite.h"

@interface XCTestView : UIView<GestureDelegate, SpriteDelegate>{
	UIImageView *bgV;
	
	NSMutableArray *sprites;

	
	ControlView *controlV;
	CGSize size;
	
	int selectedIndex; // 0-6: different color
	
	int testIndex; // 0-7 right colorindex
    int testNumberIndex;
	
	__unsafe_unretained XCLearnViewController *vc;
}

@property (nonatomic, assign) int selectedIndex;
@property (nonatomic, assign) int testIndex;
@property (nonatomic, assign) int testNumberIndex;
@property (nonatomic, unsafe_unretained) IBOutlet XCLearnViewController *vc;

- (void)load;
- (void)setup;
- (void)startCorrectAnimating;
- (void)startWrongAnimating;

@end
