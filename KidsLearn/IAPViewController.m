//
//  IAPViewController.m
//  KidsLearn
//
//  Created by  on 07.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "IAPViewController.h"

@interface IAPViewController ()

@end


@implementation IAPViewController

@synthesize rootVC;


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark -
- (IBAction)buttonClicked:(id)sender{
	L();
	
	if (sender == homeB) {
		[self.view removeFromSuperview];
		[rootVC viewDidAppear:YES];
	}
	else if (sender == iapB) {
	

		[[AudioController sharedInstance]playSound:AudioButton];
		[[LoadingView sharedLoadingView]addInView:self.view];
		[[MyStoreObserver sharedInstance]requestProductWithIdendifier:kIAPFullVersion delegate:self];


	}
	else if(sender == restoreB){
		NSLog(@"restore");
		[[LoadingView sharedLoadingView]addInView:self.view];
		[[MyStoreObserver sharedInstance]checkRestoredItemsWithDelegate:self];
	}
}

#pragma mark - IAP
- (void)didCompleteIAPWithIdentifier:(NSString*)identifier{
	L();
	
	// set 
	[[NSUserDefaults standardUserDefaults]setBool:YES forKey:kIAPFullVersion];
	
	[[NSUserDefaults standardUserDefaults]synchronize];
	
	// rootVC 不会自动调用viewwillappear
	[rootVC viewWillAppear:YES];
	[self.view removeFromSuperview];
	[rootVC viewDidAppear:YES];
}
@end
