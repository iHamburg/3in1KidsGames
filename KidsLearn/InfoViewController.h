//
//  InfoViewController.h
//  KidsLearn
//
//  Created by  on 04.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Controller.h"
#import "XCViewController.h"

@interface InfoViewController : UIViewController{
	

	IBOutlet UIButton *tweetB, *facebookB, *emailB, *app1, *app2, *backB;

}

@property (nonatomic, unsafe_unretained) XCViewController *rootVC;

- (IBAction)buttonClicked:(id)sender;

- (void)tweetus;
- (void)facebook;
- (void)email;
- (void)mehrapp1;
- (void)mehrapp2;
- (void)back;

@end
