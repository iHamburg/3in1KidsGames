//
//  XCViewController.h
//  KidsLearn
//
//  Created by XC on 6/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Controller.h"
#import "Sprite.h"


#define kTagNumberB 111
#define kTagColorB  112
#define kTagShapeB  113
#define kTagHomeB   114
#define kTagChoosePlay 115
#define kTagChooseTest 116

@class XCNumberViewController;
@class XCColorViewController;
@class XCShapeViewController;
@class XCChooseViewController;
@class IAPViewController;
@class MoreAppViewController;
@class InfoViewController;

@interface XCViewController : UIViewController{
	
    XCChooseViewController *chooseViewController;
    XCShapeViewController *shapeVC;
    XCNumberViewController *numVC;
    XCColorViewController *colorVC;
	InfoViewController *infoVC;
	MoreAppViewController *moreAppVC;
	IAPViewController *iapVC;
  
    
	IBOutlet UIButton *infoB;
	IBOutlet UIButton *moreAppB;
    IBOutlet UIButton *iapB;
	IBOutlet UIButton *startB;
	IBOutlet UIImageView *shapeLockV;
	IBOutlet UIImageView *colorLockV;
	IBOutlet UIImageView *playLockV;
	IBOutlet UIView *modulView;
	IBOutlet UIButton *play;
	IBOutlet UIButton *sprecherB;
	IBOutlet Sprite *lion;
    
//    IBOutlet Spr
	
}


@property (nonatomic, strong) IBOutlet UIButton *play;


- (IBAction)buttonClicked:(id)sender;

- (void)toInfo;
- (void)toIAP;
- (void)toMoreApp;


- (void)test;
@end
