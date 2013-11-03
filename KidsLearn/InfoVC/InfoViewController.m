//
//  Info2ViewController.m
//  InstaMagazine
//
//  Created by AppDevelopper on 13.10.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "InfoViewController.h"
#import "Utilities.h"
#import "MoreApp.h"
#import "ExportController.h"
#import <QuartzCore/QuartzCore.h>
#import "AboutUsValidator.h"
#import "MoreAppValidator.h"

@implementation InfoViewController

@synthesize selectedAppID;

- (void)loadView{

		
	self.view = [[UIView alloc] initWithFrame:_r];
	
	
	NSArray *moreAppNames;
	if (isPad) {
		moreAppNames = @[@"myecard",@"tinykitchen",@"nsc"];
	}
	else{
		moreAppNames = @[@"myecard",@"instahat",@"tinykitchen",@"nsc"];
	}

	NSString *moreAppsPlistPath = [[NSBundle mainBundle] pathForResource:@"MoreApps.plist" ofType:nil];
	NSDictionary *moreAppsDict = [NSDictionary dictionaryWithContentsOfFile:moreAppsPlistPath];
	moreApps = [NSMutableArray array];
	for (NSString *name in moreAppNames) {
		MoreApp *app = [[MoreApp alloc]initWithName:name dictionary:moreAppsDict[name]];
		[moreApps addObject:app];
	}
}



- (NSUInteger)supportedInterfaceOrientations{
    
	return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}


- (void)dealloc{
    L();

}

#pragma mark - IBAction
- (IBAction)buttonClicked:(id)sender{
	L();

}

#pragma mark -

- (void)back{
//	NSLog(@"info # %@",self);
    [_delegate infoVCWillClose:self];
}

- (void)toInstruction{


		instructionVC = [[InstructionViewController alloc]init];
		instructionVC.view.frame = self.view.bounds;
		instructionVC.delegate = self;
	
	[self.view addSubview:instructionVC.view];
}

- (void)rateUs{
    [[ExportController sharedInstance]toRate];
}

- (void)instructionVCWillDismiss:(InstructionViewController *)vc{
	[vc.view removeFromSuperview];
}

- (void)showParentalGate{

    int x = arc4random()%100;
    int y = arc4random()%100;
    
    sum = x + y;
    
    NSString *frageText = [NSString stringWithFormat:@"%d + %d",x,y];
    
    UIAlertView *parentalGateAlert = [[UIAlertView alloc] initWithTitle:@"Solve to Enter Parents Section" message:frageText delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
    parentalGateAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [parentalGateAlert show];
}



- (void)aboutus{
    


    validator = [[AboutUsValidator alloc] init];
    [validator validate];

}

- (void)parentalGateValidatorDidFail:(ParentalGateValidator *)validator{
    
}

- (void)parentalGateValidatorDidSuccess:(ParentalGateValidator *)validator{
    
}

- (void)tweetus{
	

	[[ExportController sharedInstance]sendTweetWithText:STwitter image:nil];
}

- (void)facebook{
	

//	[[FacebookManager sharedInstance]feed];
}
- (void)email{
	
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
						  SRecommendEmailTitle, @"subject",
						  @"",@"emailBody",
						  nil];
	
	[[ExportController sharedInstance] sendEmail:dict];
	
}
- (void)supportEmail{
	
	
	NSDictionary *dict2 = @{
	@"subject": SSupportEmailTitle,
	@"toRecipients": @[@"support@xappsoft.de"]
	};
	
    
	[[ExportController sharedInstance] sendEmail:dict2];
}


- (void)appstore{

    MoreApp *app = moreApps[selectedIndex];
    selectedAppID = app.fAppid;
    
    validator = [[MoreAppValidator alloc] initWithViewController:self];
    [validator validate];
    

}

- (void)selectApp:(MoreApp*)app{
    
    NSString *appid = isPaid()?app.pAppid:app.fAppid;
    
    [[ExportController sharedInstance]linkToAppStoreWithID:appid];
}
@end
