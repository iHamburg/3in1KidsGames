//
//  MoreAppViewController.m
//  KidsLearn
//
//  Created by  on 04.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "MoreAppViewController.h"

@interface MoreAppViewController ()

@end

@implementation MoreAppViewController

@synthesize rootVC;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

// myecard:
- (IBAction)toApp1:(id)sender{
	NSLog(@"myecard");
	
	[[AudioController sharedInstance]playSound:AudioButton];

	
	NSString *appStr = isPaid()?@"495584349":@"540736134";
	NSString *urlStr = [NSString stringWithFormat:@"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@&mt=8",appStr];
	
	NSURL *url = [NSURL URLWithString:urlStr];
	[[UIApplication sharedApplication] openURL:url];
	
}

// cityquiz: 425936134
- (IBAction)toApp2:(id)sender{
	NSLog(@"cityquiz");

	[[AudioController sharedInstance]playSound:AudioButton];
	NSURL *url = [NSURL URLWithString:@"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=425936134&mt=8"];
	[[UIApplication sharedApplication] openURL:url];
}

- (IBAction)back:(id)sender{
	[[AudioController sharedInstance]playSound:AudioButton];
	[self.view removeFromSuperview];
	[rootVC viewDidAppear:YES];
}
@end
