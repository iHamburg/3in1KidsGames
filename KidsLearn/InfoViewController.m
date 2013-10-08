//
//  InfoViewController.m
//  KidsLearn
//
//  Created by  on 04.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "InfoViewController.h"


@implementation InfoViewController

@synthesize rootVC;


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - IBAction

- (IBAction)buttonClicked:(id)sender{
	L();
	[[AudioController sharedInstance]playSound:AudioButton];

	if(sender == tweetB){
		[self tweetus];
	}
	else if (sender == facebookB) {
		[self facebook];
	}
	else if(sender == emailB) {
		[self email];
	}
	else if(sender == app1) {
		[self mehrapp1];
	}
	else if(sender == app2) {
		[self mehrapp2];
	}
	else if(sender == backB){
		[self back];
	}
}
#pragma mark -
- (void)tweetus{

	[[ExportController sharedInstance] sendTweet:STwitter delegate:self];
}
- (void)facebook{
	
	[[FBViewController sharedInstance]feed];
}
- (void)email{
	
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"Feedback for 3in1 Kids Games - Number, Color and Shape: Play and Learn!", @"subject",
						  [NSArray arrayWithObjects:@"support@xappsoft.de",nil],@"toRecipients",
						  nil];
	
	[[ExportController sharedInstance] sendEmail:dict delegate:self];

}
- (void)mehrapp1{
	NSLog(@"myecard");

	NSString *appStr = isPaid()?@"495584349":@"540736134";
	NSString *urlStr = [NSString stringWithFormat:@"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@&mt=8",appStr];
	
	NSURL *url = [NSURL URLWithString:urlStr];
	[[UIApplication sharedApplication] openURL:url];
	
	
}
- (void)mehrapp2{
	NSLog(@"cityquiz");
	
	
	NSURL *url = [NSURL URLWithString:@"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=425936134&mt=8"];
	[[UIApplication sharedApplication] openURL:url];
}
- (void)back{
	[[AudioController sharedInstance]playSound:AudioButton];
	[self.view removeFromSuperview];
	
	[rootVC viewDidAppear:YES];
}
@end
