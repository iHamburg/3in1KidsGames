//
//  XCColorViewController.m
//  KidsLearn
//
//  Created by XC on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XCColorViewController.h"
#import "XCColorPlayView.h"
#import "XCColorTestView.h"

@interface XCColorViewController ()

@end

@implementation XCColorViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	playV = [[XCColorPlayView alloc] initWithFrame:self.view.bounds];
	
	testV = [[XCColorTestView alloc]initWithFrame:self.view.bounds];
    
    [playB setOrigin:CGPointMake(885, 640)];
	
}


#pragma mark -
- (void)toTest{
	testV.testIndex = arc4random()%7;
	
	[super toTest];
}

#pragma mark - ColorView
- (void)colorClicked:(int)colorIndex{
	L();
	backB.hidden = NO;
	homeB.hidden = YES;
	playV.selectedIndex = colorIndex;
	[AudioController playColor:colorIndex delegate:nil];
	[self.view insertSubview:playV belowSubview:homeB];
	
}
@end
