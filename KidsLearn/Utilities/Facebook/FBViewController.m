//
//  FBViewController.m
//  FacebookTest
//
//  Created by  on 12.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "FBViewController.h"
#import "AppDelegate.h"

@interface FBViewController ()

@end

@implementation FBViewController

+(id)sharedInstance{
	static id sharedInstance;
	if (sharedInstance == nil) {
		
		sharedInstance = [[[self class] alloc]init];
	}
	
	return sharedInstance;
	
}


- (id)init{
	if (self = [super init]) {
//		L();
//		AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
//	
//		Facebook *facebook = [appDelegate facebook];
//
//		NSLog(@"facebook:%@",facebook);

	}
	return self;
}
//
//- (void)loadView{
//
//	self.view = [[UIView alloc]initWithFrame:CGRectZero];
//	
////	facebook = [[Facebook alloc] initWithAppId:@"189613711144314" andDelegate:self];
//	
////	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
////	if ([defaults objectForKey:@"FBAccessTokenKey"] 
////        && [defaults objectForKey:@"FBExpirationDateKey"]) {
////        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
////        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
////	}
////	
////	if (![facebook isSessionValid]) {
////		[facebook authorize:nil];
////	}
//
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)feed{
	AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
	
	Facebook *facebook = [appDelegate facebook];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if ([defaults objectForKey:@"FBAccessTokenKey"] 
		&& [defaults objectForKey:@"FBExpirationDateKey"]) {
		NSLog(@"has tokenkey");
		facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
		facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
	}
	
	if (![facebook isSessionValid]) {
		[facebook authorize:nil];
	}
	
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   FBAppID, @"app_id",
								   @"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=495584349&mt=8/", @"link",
								   @"http://www.xappsoft.de/img/Kidslearn.png", @"picture",
								   @"3in1 Kids Games", @"name",
								   @"Number, Color and Shape: Play and Learn!", @"caption",
								   @"3in1 Kids Games - Number, Color and Shape simplifies children’s learning process, educates and entertains your little one while having lots of fun! ", @"description",
								   nil];
	
	[facebook dialog:@"feed" andParams:params andDelegate:self];


}

- (void)sendImage:(UIImage*)img delegate:(id)_delegate{
	AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
	
	Facebook *facebook = [appDelegate facebook];
	delegate = _delegate;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if ([defaults objectForKey:@"FBAccessTokenKey"] 
		&& [defaults objectForKey:@"FBExpirationDateKey"]) {
		NSLog(@"has tokenkey");
		facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
		facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
	}
	
	NSLog(@"facebook:%@",facebook);
	
	if (![facebook isSessionValid]) {
		
		[facebook authorize:nil];
	}
	else {
		NSLog(@"fb is already authorized");
	}

	
	NSData *picData = UIImageJPEGRepresentation(img, 0.8);
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   @"via My eCard",@"message",
                                   picData, @"picture",
                                   nil];
    
	
	NSLog(@"begin send");
	
	
	
    [facebook requestWithGraphPath:@"me/photos"
									andParams:params
								andHttpMethod:@"POST"
								  andDelegate:self];
//	
//	NSURL *picUrl = [NSURL fileURLWithPath:[NSString dataFilePath:@"temp.jpg"]];
//	NSData *picData = UIImageJPEGRepresentation(img, 0.8);
//	NSLog(@"picUrl:%@",picUrl.description);
//	NSMutableDictionary* params2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//								   FBAppID, @"app_id",
//								   @"http://www.xappsoft.de/", @"link",
//								   @"My ecard", @"name",
//								   @"Xappsoft", @"caption",
//								   @"Description", @"description",
////									picData, @"picture",
//
//								   nil];

	
//	NSMutableDictionary *params2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                   @"I'm using the Hackbook for iOS app222", @"name",
//                                   @"Hackbook for iOS.", @"caption",
//                                   @"Check out Hackbook for iOS to learn how you can make your iOS apps social using Facebook Platform.", @"description",
//								   //                                   @"http://m.facebook.com/apps/hackbookios/", @"link",
////                                   @"http://www.facebookmobileweb.com/hackbook/img/facebook_icon_large.png", @"picture",
//								   //                                   actionLinksStr, @"actions",
//                                   nil];
//	
//    HackbookAppDelegate *delegate = (HackbookAppDelegate *)[[UIApplication sharedApplication] delegate];
//    
//	[facebook dialog:@"feed" andParams:params2 andDelegate:self];

	
}


#pragma mark - FBSessionDelegate Methods



- (void)fbDidLogin {
	
	NSLog(@"fb Did login");
	AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
	
	Facebook *facebook = [appDelegate facebook];
	
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
	
}


/**
 * Called when the user has logged in successfully.
 */

-(void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    NSLog(@"token extended");
	//    [self storeAuthData:accessToken expiresAt:expiresAt];
}

/**
 * Called when the user canceled the authorization dialog.
 */
-(void)fbDidNotLogin:(BOOL)cancelled {
	NSLog(@"fb not login");
	//    [pendingApiCallsController userDidNotGrantPermission];
}

/**
 * Called when the request logout has succeeded.
 */
- (void)fbDidLogout {
	//    pendingApiCallsController = nil;
    
    // Remove saved authorization information if it exists and it is
    // ok to clear it (logout, session invalid, app unauthorized)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"FBAccessTokenKey"];
    [defaults removeObjectForKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
	//    [self showLoggedOut];
}

/**
 * Called when the session has expired.
 */
- (void)fbSessionInvalidated {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Auth Exception"
                              message:@"Your session has expired."
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil,
                              nil];
    [alertView show];
    [self fbDidLogout];
}


#pragma mark - FBRequestDelegate Methods
/**
 * Called when the Facebook API request has returned a response.
 *
 * This callback gives you access to the raw response. It's called before
 * (void)request:(FBRequest *)request didLoad:(id)result,
 * which is passed the parsed response object.
 */
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
	
	
    NSLog(@"received response");
	
	//发声音作为提示更好
	
//	[[LoadingView sharedLoadingView]showTitle:@"Added into Facebook" inView:[delegate view]];
//	[[AudioController sharedInstance]play:AudioTypeFacebook delegate:nil];
	[[LoadingView sharedLoadingView]showTitle:LString(@"Done") inView:[delegate view]];
//	[FlurryAnalytics logEvent:@"Facebook Sent"];
}

/**
 * Called when a request returns and its response has been parsed into
 * an object.
 *
 * The resulting object may be a dictionary, an array or a string, depending
 * on the format of the API response. If you need access to the raw response,
 * use:
 *
 * (void)request:(FBRequest *)request
 *      didReceiveResponse:(NSURLResponse *)response
 */
- (void)request:(FBRequest *)request didLoad:(id)result {
	
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
	
	NSLog(@"result:%@",result);
	
   }

/**
 * Called when an error prevents the Facebook API request from completing
 * successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"Err message: %@", [[error userInfo] objectForKey:@"error_msg"]);
    NSLog(@"Err code: %d", [error code]);
	
	
	
//	[[LoadingView sharedLoadingView]showTitle:LString(@"Error") inView:[delegate view]];
	[[LoadingView sharedLoadingView] showTitle:LString(@"tryitagain") inView:[delegate view]];
}



@end
