//
//  XCLearnViewController.h
//  KidsLearn
//
//  Created by  on 19.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Controller.h"
#import "QuartzCore/QuartzCore.h"
#import "Sprite.h"
#import "XCViewController.h"

/*
 点击button －》XCPlayView
 
 点击猴子   －》 XCTestView
 */

@class XCTestView;
@class XCPlayView;
@interface XCLearnViewController : UIViewController{
	
	// 点击－》XCTestView, sprite figur
	UIView *testAnimationView;

	IBOutlet UIButton *backB;
	IBOutlet UIButton *homeB;
	IBOutlet UIButton *playB;
	IBOutlet UIImageView *bgV;
	
	XCTestView *testV;
	XCPlayView *playV;
	
	NSArray *playVs;
	NSArray *testVs;
    
    __unsafe_unretained XCViewController *rootVC;
}

@property (nonatomic, unsafe_unretained) XCViewController *rootVC;

// back, home, test
- (IBAction)buttonClicked:(id)sender;

- (IBAction)itemButtonClicked:(id)sender;



- (void)toHome;
- (void)back; // to vc.view
- (void)toTest;

@end
