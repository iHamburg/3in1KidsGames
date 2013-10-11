//
//  XCNumberModusViewController.m
//  KidsLearn
//
//  Created by XC on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XCNumberViewController.h"
#import "XCNumberPlayView.h"
#import "XCNumberTestView.h"
#import "XCNumberBallonPlayView.h"
#import "XCNumberRoleCallPlayView.h"

@interface XCNumberViewController ()

@end

@implementation XCNumberViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	//因为没有把playV和testV 加到subview中，所以不会自动变形
	playV = [[XCNumberRoleCallPlayView alloc] initWithFrame:self.view.bounds];
	playV.autoresizingMask = kAutoResize;
	testV = [[XCNumberTestView alloc]initWithFrame:self.view.bounds];
	testV.autoresizingMask = kAutoResize;

}

//number 0-9
-(IBAction)itemButtonClicked:(id)sender{
    L();
    int index = [sender tag];  // 2-11
	
	// toPlayV
  	playV.selectedIndex = index-2;

	backB.hidden = NO;
	homeB.hidden = YES;
 
//    [backB setBackgroundImage:[UIImage imageNamed:@"back_white.png"] forState:UIControlStateNormal];
//    [backB setOrigin:CGPointMake(10, 350)];
    
	[self.view insertSubview:playV belowSubview:backB];
	
	[(XCNumberPlayView*)playV play];
	[[AudioController sharedInstance] playWaterMusic];

}

- (void)back{
    // cancel playV.performance
    
    [NSObject cancelPreviousPerformRequestsWithTarget:playV];
    [[AudioController sharedInstance] stopWaterMusic];
    [super back];
}

- (void)toTest{
	
	L();
	
    [backB setBackgroundImage:[UIImage imageNamed:@"back_yellow.png"] forState:UIControlStateNormal];
    [backB setOrigin:CGPointMake(0, 20)];
    testV.testNumberIndex = arc4random()%10;

	testV.frame = kFrameUniversalHorizont;
	
    NSLog(@"numVC:%@,testV:%@",self.view,testV);
	[super toTest];
}

@end
