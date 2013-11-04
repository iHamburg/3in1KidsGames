//
//  IAPViewController.m
//  KidsLearn
//
//  Created by  on 07.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "IAPViewController.h"
#import "AdView.h"

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
	
    validator = [[ParentalGateValidator alloc] init];
    
	if (sender == homeB) {
		[self.view removeFromSuperview];
		[rootVC viewDidAppear:YES];
	}
	else if (sender == iapB) {
	

		[[AudioController sharedInstance]playSound:AudioButton];
		[[LoadingView sharedLoadingView]addInView:self.view];
        
        __weak IAPViewController *vc = self;
        validator.completionHandler = ^(BOOL completed){
            if (completed) {
                [[MyStoreObserver sharedInstance]requestProductWithIdendifier:kIAPFullVersion delegate:vc];
            }
        };
        [validator validate];


	}
	else if(sender == restoreB){
		NSLog(@"restore");
		[[LoadingView sharedLoadingView]addInView:self.view];
		
        
        __weak IAPViewController *vc = self;
        validator.completionHandler = ^(BOOL completed){
            if (completed) {
                [[MyStoreObserver sharedInstance]checkRestoredItemsWithDelegate:vc];
            }
        };
        [validator validate];

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
    [AdView releaseSharedInstance];
}
@end
