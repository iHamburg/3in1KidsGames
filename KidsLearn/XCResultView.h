//
//  XCDrawResult.h
//  KidsLearn
//
//  Created by XC on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XCChooseViewController.h"
//for grid
#define StartX 230
#define StartY 110
#define Width 210
#define Hight 187
//for triangle
#define DisY 30
#define DisX 20
//for rectangle
#define DisWidth 20
#define DisHight 50
//for pentagon
#define PenUnit 205
#define PenMargin 10
//for diamond
#define DisDiamond 30

@interface XCResultView : UIView {

	UIImageView *drawV;
    
}

@property (nonatomic, assign) Shape shape;
@property (nonatomic, assign) Color color;
@property (nonatomic, assign) int numberIndex;

- (void)setup;

@end
