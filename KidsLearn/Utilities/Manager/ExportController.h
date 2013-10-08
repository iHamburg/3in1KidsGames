//
//  ExportController.h
//  FirstThings_Uni
//
//  Created by  on 12.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import <Twitter/Twitter.h>
#import "Utilities.h"
#import "FlurryAnalytics.h"
#import "LoadingView.h"

@interface ExportController : NSObject<MFMailComposeViewControllerDelegate, UIAlertViewDelegate>{
	MFMailComposeViewController *mailPicker;
}


+(id)sharedInstance;

- (void)sendEmail:(NSDictionary*)info delegate:(id)delegate;


- (void)sendTweet:(NSString*)text delegate:(id)delegate;
- (void)sendTweetWithImage:(UIImage*)img delegate:(id)delegate;

- (void)toRate;
- (void)showRateAlert;
@end
