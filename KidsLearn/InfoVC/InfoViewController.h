//
//  Info2ViewController.h
//  InstaMagazine
//
//  Created by AppDevelopper on 13.10.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstructionViewController.h"
#import "MoreApp.h"

@protocol InfoDelegate;

@interface InfoViewController : UIViewController<InstructionDelegate>{

	InstructionViewController *instructionVC;
	UIButton *backB;

	NSMutableArray *moreApps;

	__unsafe_unretained id<InfoDelegate> _delegate;
	int selectedIndex;

}

@property (nonatomic, unsafe_unretained) id<InfoDelegate> delegate;

- (void)back;
- (void)toInstruction;
- (void)rateUs;
- (void)aboutus;
- (void)tweetus;
- (void)facebook;
- (void)email;
- (void)supportEmail;

- (void)selectApp:(MoreApp*)app;

@end

@protocol InfoDelegate <NSObject>

- (void)infoVCWillClose:(InfoViewController*)infoVC;

@end