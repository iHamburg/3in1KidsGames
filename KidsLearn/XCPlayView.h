//
//  XCPlayView.h
//  KidsLearn
//
//  Created by  on 18.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Controller.h"
#import "Sprite.h"
#import "XCShapeViewController.h"

@interface XCPlayView : UIView<SpriteDelegate>{
	UIImageView *bgV;
	UIButton *indexButton;

	
	NSDictionary *infoDict;
	
	NSMutableArray *sprites; // all sprites
	NSArray *playSprites; // sprites show in the playView
	
	int selectedIndex;
	CGSize size;
    
    __unsafe_unretained XCShapeViewController *vc;

}
@property (nonatomic, unsafe_unretained) XCShapeViewController *vc;
@property (nonatomic, assign) int selectedIndex;

- (void)load;
- (void)setup;
- (void)play;
@end
