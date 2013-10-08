//
//  XCShapeViewController.m
//  KidsLearn
//
//  Created by XC on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XCShapeViewController.h"

#import "XCShapePlayView.h"
#import "XCShapeTestView.h"
#import "CirclePlayView.h"

@interface XCShapeViewController ()

@end

@implementation XCShapeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.


	playClassNames = [NSArray arrayWithObjects:@"CirclePlayView",@"SquarePlayView",@"TrianglePlayView",@"RectanglePlayView",@"PentagonPlayView",@"DiamondPlayView", nil];
	testClassNames = [NSArray arrayWithObjects:@"CircleTestView",@"SquareTestView",@"TriangleTestView",@"RectangleTestView",@"PentagonTestView",@"DiamondTestView", nil];

	shapeV.drawOrigin = CGPointMake(140, 170);
    
    [playB setOrigin:CGPointMake(769, 666)];
    [backB setBackgroundImage:[UIImage imageNamed:@"back_white.png"] forState:UIControlStateNormal];
    backB.frame = CGRectMake(0, 300, 128, 128);
}


#pragma mark - ShapeView
// click to playV
- (void)shapeView:(XCShapeView *)shapeView didClickShape:(Shape)shape{

	L();
	backB.hidden = NO;
	homeB.hidden = YES;


	NSString *playName = [playClassNames objectAtIndex:shape];
	NSLog(@"playname:%@",playName);
	playV = [[NSClassFromString(playName) alloc]initWithFrame:self.view.bounds];
	playV.vc = self;
	playV.selectedIndex = shape;
	
	[self.view insertSubview:playV belowSubview:homeB];
	[playV play];
}


- (void)toTest{
	L();
//	testV.testIndex = arc4random()%7;
	backB.hidden = NO;
	homeB.hidden = YES;
	
	int testVIndex = arc4random()%[testClassNames count]; 
	NSString *testName = [testClassNames objectAtIndex:testVIndex];
	testV = [[NSClassFromString(testName) alloc]initWithFrame:self.view.bounds];
	testV.selectedIndex = testVIndex;

	
	[super toTest];
}

- (void)toTest:(Shape)shapeIndex{
    L();
    backB.hidden = NO;
	homeB.hidden = YES;
	
	
	NSString *testName = [testClassNames objectAtIndex:shapeIndex];
	testV = [[NSClassFromString(testName) alloc]initWithFrame:self.view.bounds];
	testV.selectedIndex = shapeIndex;
    
	[super toTest];

}
@end
