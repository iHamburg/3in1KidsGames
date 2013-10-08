//
//  XCLearnViewController.m
//  KidsLearn
//
//  Created by  on 19.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "XCLearnViewController.h"
#import "XCTestView.h"
#import "XCPlayView.h"


@interface XCLearnViewController ()

@end

@implementation XCLearnViewController

@synthesize rootVC;



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	L();
	
	homeB = [UIButton buttonWithFrame:CGRectMake(10, 10, 60, 60) title:nil image:[UIImage imageNamed:@"Icon_home_new.png"] target:self actcion:@selector(buttonClicked:)];
	homeB.hidden = NO;
	homeB.autoresizingMask = kAutoResize;
	
	backB = [UIButton buttonWithFrame:CGRectMake(10, 10, 100, 100) title:nil image:[UIImage imageNamed:@"back_yellow.png"] target:self actcion:@selector(buttonClicked:)];
	backB.hidden = YES;
	backB.autoresizingMask = kAutoResize;
	
	playB = [UIButton buttonWithFrame:CGRectMake(709, 666, 132, 62) title:nil image:[UIImage imageNamed:@"View_Colors_playBtn.png"] target:self actcion:@selector(buttonClicked:)];
	playB.autoresizingMask = kAutoResize;
	
	[self.view addSubview:playB];
	[self.view addSubview:homeB];
	[self.view addSubview:backB];

}

- (void)viewWillDisappear:(BOOL)animated{
	L();
	[super viewWillDisappear:animated];
	
	// remove playV and testV
	[playV removeFromSuperview];
	[testV removeFromSuperview];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - IBAction
- (IBAction)buttonClicked:(id)sender{

	[[AudioController sharedInstance]playSound:AudioButton];
	
	if (sender == homeB) { // to rootVC(home)
		
		[self toHome];
	}
	else if(sender == backB) {
		
        [self back];
	
	}
	else if(sender == playB) {
		backB.hidden = NO;
		homeB.hidden = YES;

		[self toTest];
	}
	
}

- (IBAction)itemButtonClicked:(id)sender{
	
}

#pragma mark - Navigation
- (void)toHome{
	
    
	[self.view removeFromSuperview];
    [rootVC viewDidAppear:YES];
}

// to vc.view
- (void)back{
    backB.hidden = YES;
    homeB.hidden = NO;
    
    [testV removeFromSuperview];
    [playV removeFromSuperview];
}
- (void)toTest{
	[self.view insertSubview:testV belowSubview:backB];

}
@end
