//
//  MoreAppViewController.h
//  KidsLearn
//
//  Created by  on 04.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Controller.h"
#import "XCViewController.h"

@interface MoreAppViewController : UIViewController

@property (nonatomic, unsafe_unretained) XCViewController *rootVC;

- (IBAction)toApp1:(id)sender;
- (IBAction)toApp2:(id)sender;
- (IBAction)back:(id)sender;

@end
