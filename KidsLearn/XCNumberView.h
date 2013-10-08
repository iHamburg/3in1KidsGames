//
//  XCNumberView.h
//  KidsLearn
//
//  Created by XC on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCChooseViewController.h"
@interface XCNumberView : UIView{
    IBOutlet XCChooseViewController *chooseVC;
  
}


- (IBAction)buttonClicked:(id)sender;
@end
