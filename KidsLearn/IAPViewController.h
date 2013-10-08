//
//  IAPViewController.h
//  KidsLearn
//
//  Created by  on 07.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Controller.h"
#import "XCViewController.h"
#import "MyStoreObserver.h"

@interface IAPViewController : UIViewController<IAPDelegate>{
	IBOutlet UIButton *homeB;
	IBOutlet UIButton *iapB ,*restoreB;
}

@property (nonatomic, unsafe_unretained) XCViewController *rootVC;

- (IBAction)buttonClicked:(id)sender;


@end
