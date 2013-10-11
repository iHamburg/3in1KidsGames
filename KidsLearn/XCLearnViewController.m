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
//	L();    
	
	homeB = [UIButton buttonWithFrame:CGRectMake(10, 10, 60, 60) title:nil image:[UIImage imageNamed:@"Icon_home_new.png"] target:self action:@selector(buttonClicked:)];
	homeB.hidden = NO;
	homeB.autoresizingMask = kAutoResize;
	
	backB = [UIButton buttonWithFrame:CGRectMake(10, 10, 100, 100) title:nil image:[UIImage imageNamed:@"back_yellow.png"] target:self action:@selector(buttonClicked:)];
	backB.hidden = YES;
	backB.autoresizingMask = kAutoResize;
	
	playB = [UIButton buttonWithFrame:CGRectMake(709, 640, 132, 62) title:nil image:[UIImage imageNamed:@"View_Colors_playBtn.png"] target:self action:@selector(buttonClicked:)];
	playB.autoresizingMask = kAutoResize;
	
	[self.view addSubview:playB];
	[self.view addSubview:homeB];
	[self.view addSubview:backB];

}


- (void)viewWillDisappear:(BOOL)animated{
//	L();
	[super viewWillDisappear:animated];
	
	// remove playV and testV
	[playV removeFromSuperview];
	[testV removeFromSuperview];
}


- (void)viewDidAppear:(BOOL)animated{
    //    L();
    [super viewDidAppear:animated];
    [self layoutADBanner:[AdView sharedInstance]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notification

- (void)registerNotifications{
    
    //
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleAdviewNotification:) name:NotificationAdChanged object:nil];
    
}

- (void)handleAdviewNotification:(NSNotification*)notification{
    [self layoutADBanner:notification.object];
    
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

        NSLog(@"playB # %@",sender);
		[self toTest];
	}
	
}

- (IBAction)itemButtonClicked:(id)sender{
	
}

#pragma mark - AdView
- (void)layoutADBanner:(AdView *)banner{
    L();
    //    if (!banner.isAdDisplaying) {
    //        [banner setOrigin:CGPointMake(0, _h)];
    //    }
    
    [UIView animateWithDuration:0.25 animations:^{
		
		if (banner.isAdDisplaying) { // 从不显示到显示banner
            
			[banner setOrigin:CGPointMake(0, _h - banner.height)];
            //			[bgV setOrigin:CGPointMake(0, -banner.height)];
            //            [bottomBanner setOrigin:CGPointMake(0, _h -bottomBanner.height - banner.height)];
            //            [carousel setOrigin:CGPointMake(0, topBanner.height - _hAdBanner)];
			[rootVC.view addSubview:banner];
            
//            NSLog(@"root subview # %@",rootVC.view.subviews);
//            NSLog(@"banner # %@",banner);
		}
		else{
			[banner setOrigin:CGPointMake(0, _h)];
            //			[bgV setOrigin:CGPointMake(0, 0)];
            //            [bottomBanner setOrigin:CGPointMake(0, _h -bottomBanner.height)];
            //            [carousel setOrigin:CGPointMake(0, topBanner.height)];
		}
		
    }];
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
