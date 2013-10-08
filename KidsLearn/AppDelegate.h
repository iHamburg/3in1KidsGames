//
//  XCAppDelegate.h
//  KidsLearn
//
//  Created by XC on 6/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "FBViewController.h"

#define FBAppID @"280143022093804"

@class XCViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) XCViewController *viewController;

@property (nonatomic, strong) Facebook *facebook;

@end
