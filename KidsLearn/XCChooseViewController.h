//
//  XCChooseViewController.h
//  KidsLearn
//
//  Created by XC on 6/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Controller.h"
#import "XCShapeView.h"
#import "XCColorView.h"
#import "XCViewController.h"

typedef enum {
    SpielPageNumber,
    SpielPageColor,
    SpielPageShape,
    SPielPageResult,
}ChoosePage;

@class XCNumberView;

@class XCShapeView;
@class XCResultView;

@interface XCChooseViewController : UIViewController<ShapeViewDelegate,ColorViewDelegate> {
    IBOutlet UIButton   *home; //icon home, will go back to home screen if clicked

    IBOutlet XCNumberView     *containerNumbers;
    IBOutlet XCColorView     *containerColors;
    IBOutlet XCShapeView     *containerShapes;
	IBOutlet XCResultView    *resultV;
	
	UIScrollView *scollContrainer;
    IBOutlet UIButton *sheep;

	IBOutlet UIButton *againB;
    
	Shape selectedShapeIndex;
    Color selectedColorIndex;
    int selectedNumberIndex;
    
    int testNumberindex, testColorIndex, testShapeIndex;
    
    ChoosePage page;
    
}

@property (nonatomic, strong) IBOutlet UIButton *home;

@property (nonatomic, strong) IBOutlet XCNumberView *containerNumbers;
@property (nonatomic, strong) IBOutlet XCColorView *containerColors;
@property (nonatomic, strong) IBOutlet XCShapeView *containerShapes;

@property (nonatomic, assign) int selectedNumberIndex;

@property (nonatomic, strong) IBOutlet UIButton *sheep;
@property (nonatomic, strong) IBOutlet UIButton *toNumberModus, *toColorModus, *toShapeModus;

@property (nonatomic, assign) SpielMode mode;

@property (nonatomic, unsafe_unretained) XCViewController *rootVC;

- (void)setup;

- (IBAction)buttonClicked:(id)sender;
//-(IBAction)goHomeView:(id)sender;
-(IBAction)sheepPressed:(id)sender;
//-(void)startAnimation:(UIButton*)btn;

- (void)toNumber;
- (void)toColor;
- (void)toShape;
- (void)toResult;

- (void)willToNumber;
- (void)willToColor;
- (void)willToShape;

- (void)numberClicked:(int)numberIndex; //from NumberView: 0 - 9
- (void)colorClicked:(int)colorIndex;


@end
