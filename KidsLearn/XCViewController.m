//
//  XCViewController.m
//  KidsLearn
//
//  Created by XC on 6/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XCViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "XCNumberViewController.h"
#import "XCColorViewController.h"
#import "XCShapeViewController.h"
#import "XCChooseViewController.h"
#import "IAPViewController.h"
#import "InfoViewController.h"
#import "MoreAppViewController.h"

@interface XCViewController ()

@end

@implementation XCViewController

@synthesize play;



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    L();
    
	[Controller sharedInstance];
	
	chooseViewController = [[XCChooseViewController alloc] initWithNibName:@"XCChooseViewController" bundle:nil];
    chooseViewController.rootVC = self;
	chooseViewController.view.frame = kFrameUniversalHorizont;
    numVC = [[XCNumberViewController alloc] initWithNibName:@"XCNumberViewController" bundle:nil];
    numVC.rootVC =self;
	numVC.view.frame = kFrameUniversalHorizont;
    colorVC = [[XCColorViewController alloc]initWithNibName:@"XCColorViewController" bundle:nil];
    colorVC.rootVC = self;
	colorVC.view.frame = kFrameUniversalHorizont;
    shapeVC = [[XCShapeViewController alloc]initWithNibName:@"XCShapeViewController" bundle:nil];
    shapeVC.rootVC = self;
	shapeVC.view.frame = kFrameUniversalHorizont;
	infoVC = [[InfoViewController alloc]initWithNibName:@"InfoViewController" bundle:nil];
	infoVC.rootVC = self;
	infoVC.view.frame = kFrameUniversalHorizont;
	moreAppVC = [[MoreAppViewController alloc]initWithNibName:@"MoreAppViewController" bundle:nil];
	moreAppVC.rootVC = self;
	moreAppVC.view.frame = kFrameUniversalHorizont;
	iapVC = [[IAPViewController alloc] initWithNibName:@"IAPViewController" bundle:nil];
	iapVC.rootVC = self;
	iapVC.view.frame = kFrameUniversalHorizont;
	
	lion.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"lion_animation1.png"],[UIImage imageNamed:@"lion_animation2.png"], nil];
	lion.animationRepeatCount = 0;
	lion.animationDuration = 1;
	
	BOOL silent = [[AudioController sharedInstance]silent];	
	UIImage *sprecherImg = silent?[UIImage imageNamed:@"icon_sprecher_off.png"]:[UIImage imageNamed:@"icon_sprecher_on.png"];
	sprecherB = [UIButton buttonWithFrame:CGRectMake(10, 10, 50, 50) title:nil image:sprecherImg target:self actcion:@selector(buttonClicked:)];
	sprecherB.autoresizingMask = kAutoResize;
	[self.view addSubview:sprecherB];
	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

- (void)viewWillAppear:(BOOL)animated{
	L();
	[super viewWillAppear:animated];
	
	
	if (isPaid()||isIAPFullVersion) {
		
		iapB.hidden = YES;
		shapeLockV.hidden = YES;
		colorLockV.hidden = YES;
		playLockV.hidden = YES;

	}	
}

- (void)viewDidAppear:(BOOL)animated{
	L();
	NSLog(@"root:%@",self.view);
	[super viewDidAppear:animated];
	
	[lion startAnimating];
	
	[[AudioController sharedInstance] playBGMusic];
	
	[self test];
	
	NSLog(@"numVC:%@",numVC.view);
}

- (void)viewDidDisappear:(BOOL)animated{
	L();
	[super viewDidDisappear:animated];
	
	[lion stopAnimating];
	[[AudioController sharedInstance] stopBGMusic];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
//    return YES;
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
	
}

#pragma mark - Navigation

- (void)toIAP{
//	[AudioController stopBGMusic];
	
	[self.view addSubview:iapVC.view];
	[self viewDidDisappear:YES];
}
- (void)toInfo{
//	[AudioController stopBGMusic];
	[self.view addSubview:infoVC.view];
	[self viewDidDisappear:YES];
}

- (void)toMoreApp{

	[self.view addSubview:moreAppVC.view];
	[self viewDidDisappear:YES];
}

#pragma mark - IBAction
- (IBAction)buttonClicked:(id)sender{
    
	[[AudioController sharedInstance]playSound:AudioButton];
	
    int tag = [sender tag];
    
    if(tag == kTagNumberB){
        
		[[Controller sharedInstance] setMode:spielModeNumberLearn];
//		[AudioController stopBGMusic];
		[self.view addSubview:numVC.view];
		[self viewDidDisappear:YES];
		
    }
    else if (tag == kTagColorB) {
//		[AudioController stopBGMusic];
		if (isPaid()||isIAPFullVersion) {
			[[Controller sharedInstance] setMode:spielModeColorLearn];
			[self.view addSubview:colorVC.view];
			[self viewDidDisappear:YES];
		}
		else {
			[self toIAP];
		}

    }
    else if(tag == kTagShapeB){

		if (isPaid()||isIAPFullVersion) {
			[[Controller sharedInstance] setMode:SpielModeShapeLearn];
			[self.view addSubview:shapeVC.view];
			[self viewDidDisappear:YES];
		}
		else {
			[self toIAP];
		}
		
    }
	else if(tag == kTagChoosePlay) {

		if (isPaid()||isIAPFullVersion) {

			[self.view addSubview:chooseViewController.view];
			[self viewDidDisappear:YES];
			chooseViewController.sheep.hidden = NO;

		}
		else {
			[self toIAP];
		}

	}
	
	if (sender == infoB) {
		[self toInfo];
	}
	else if(sender == moreAppB) {
		[self toMoreApp];
	}
	else if (sender == iapB) {

		[self toIAP];
	}
	else if(sender == startB){
		

		NSLog(@"modulview:%@",modulView);
		[UIView animateWithDuration:0.6 animations:^{
			startB.transform = CGAffineTransformMakeScale(0.01, 0.01);
		} completion:^(BOOL finished) {
			[UIView animateWithDuration:1 animations:^{
				[modulView moveOrigin:CGPointMake(isPad?-950:-445, 0)];
			}];
			
		}];	
	}
	else if(sender == sprecherB){
		
		BOOL silent = ![[AudioController sharedInstance]silent];
		NSLog(@"new Silent:%d",silent);
		[[NSUserDefaults standardUserDefaults]setBool:silent forKey:@"silent"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		[[AudioController sharedInstance]setSilent:silent];
		[sprecherB setBackgroundImage:silent?[UIImage imageNamed:@"icon_sprecher_off.png"]:[UIImage imageNamed:@"icon_sprecher_on.png"] forState:UIControlStateNormal];
		
		if (silent) {
			
			[[AudioController sharedInstance] stopBGMusic];
		}
		else {
			//			[self playBGMusicWithScene:SceneHome];
			[[AudioController sharedInstance] playBGMusic];
		}


	}
}





#pragma mark - Test
- (void)test{
	L();
	
//	
//	NSMutableArray *array = [NSMutableArray array];
//	for (int i = 0; i<100; i++) {
//		[array addObject:[NSString stringWithInt:i]];
//		
//	}
//	
//	NSArray *array2 = [NSArray arrayFromArray:array withRandom:10];
//	NSLog(@"new array:%@",array2);
//	
//	[self showRateAlert];
	
//	[[ExportController sharedInstance]showRateAlert];
	
//	NSLog(@"ispaid:%d",isPaid());
}
@end
