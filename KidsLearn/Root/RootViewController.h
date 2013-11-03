//
//  RootViewController.h
//  iCamAlbum
//
//  Created by AppDevelopper on 13-10-11.
//  Copyright (c) 2013年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoViewController.h"
#import "AdView.h"

@interface RootViewController : UIViewController<InfoDelegate,InstructionDelegate> {
    InfoViewController *infoVC;
    InstructionViewController *instructionVC;

    BOOL rootLoadViewFlag;
	BOOL isFirstOpen, isUpdateOpen;
    
	NSMutableArray *testObjs;
}


+ (id)sharedInstance;
- (void)registerNotification;

- (void)loadAdView;
- (void)handleAppFirstTimeOpen;
- (void)handleRootFirstDidAppear;

- (void)test;
@end
