//
//  XCInfoViewController.m
//  3in1KidsGames
//
//  Created by AppDevelopper on 13-10-9.
//
//

#import "XCInfoViewController.h"
#import "Utilities.h"
#import "FBViewController.h"
#import "ExportController.h"


#define kFontName @"Futura-CondensedMedium"

@implementation XCInfoViewController

- (void)loadView{
    [super loadView];
   
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BG_pattern_info.png"]];
	
	
	
	// w,h: 100/42, 有margin
	float faktor = kUniversalFaktor;
	CGFloat xBMargin = isPad?65:30;
    //	CGFloat yBMargin = isPad?0:-20;
	CGFloat wButton = isPad?80:40;
	CGFloat hButton = isPad?80:40;
	CGFloat yButtonsMargin = isPad?20:7;
	CGFloat hLabel = isPad?30:14;
	
	backB = [UIButton buttonWithFrame:CGRectMake(3, 3, isPad?60:30, isPad?60:30) title:nil imageName:@"icon_back.png" target:self action:@selector(back)];
    
	
    //	instructionB = [UIButton buttonWithFrame:CGRectMake(xBMargin, yBMargin, wButton, hButton) title:nil imageName:@"Info_Instruction.png" target:self action:@selector(toInstruction)];
	UILabel *instructionL = [[UILabel alloc]initWithFrame:CGRectMake(xBMargin-20, CGRectGetMaxY(instructionB.frame), wButton+40, hLabel)];
	instructionL.text = @"Instruction";
	
	aboutB = [UIButton buttonWithFrame:CGRectMake(xBMargin, CGRectGetMaxY(instructionL.frame)+yButtonsMargin, wButton, hButton) title:nil imageName:@"Info_Xapp.png" target:self action:@selector(aboutus)];
	UILabel *aboutL = [[UILabel alloc]initWithFrame:CGRectMake(xBMargin-20, CGRectGetMaxY(aboutB.frame), wButton+40, hLabel)];
	aboutL.text = @"About Us";
	recommendB = [UIButton buttonWithFrame:CGRectMake(xBMargin, CGRectGetMaxY(aboutL.frame)+ yButtonsMargin, wButton, wButton*0.66) title:nil imageName:@"Info_Recommend.png" target:self action:@selector(email)];
	UILabel *recommendL = [[UILabel alloc]initWithFrame:CGRectMake(xBMargin-20, CGRectGetMaxY(recommendB.frame), wButton+40, hLabel)];
	recommendL.text = @"Recommend";
	supportB = [UIButton buttonWithFrame:CGRectMake(xBMargin, CGRectGetMaxY(recommendL.frame)+ yButtonsMargin, wButton, hButton) title:nil imageName:@"Info_Support.png" target:self action:@selector(supportEmail)];
	UILabel *supportL = [[UILabel alloc]initWithFrame:CGRectMake(xBMargin-20, CGRectGetMaxY(supportB.frame), wButton+40, hLabel)];
	supportL.text = @"Support";
	facebookB = [UIButton buttonWithFrame:CGRectMake(xBMargin, CGRectGetMaxY(supportL.frame)+ yButtonsMargin, wButton, hButton) title:nil imageName:@"Info_Facebook.png" target:self action:@selector(facebook)];
	twitterB = [UIButton buttonWithFrame:CGRectMake(xBMargin, CGRectGetMaxY(facebookB.frame)+ yButtonsMargin, wButton, hButton) title:nil imageName:@"Info_Twitter.png" target:self action:@selector(tweetus)];
    
	
	NSArray *buttons = @[aboutB,recommendB,supportB,facebookB,twitterB];
	
    for (UIButton *b in buttons) {
		b.layer.shadowColor = [UIColor colorWithWhite:0.4 alpha:0.8].CGColor;
		b.layer.shadowOpacity = 1;
		b.layer.shadowOffset = isPad?CGSizeMake(2, 2):CGSizeMake(1, 1);
		b.layer.shadowRadius = 1;
        //		b.backgroundColor = [UIColor redColor];
	}
	
	NSArray *labels = @[aboutL,recommendL,supportL];
	for (UILabel *l in labels) {
		
		l.textAlignment = NSTextAlignmentCenter;
		l.backgroundColor = [UIColor clearColor];
		l.textColor = [UIColor colorWithRed:0 green:103.0/255 blue:132.0/255 alpha:1];
		l.font = [UIFont fontWithName:kFontName size:isPad?20:10];
		l.shadowColor = [UIColor colorWithWhite:0.6 alpha:0.8];
		l.shadowOffset = CGSizeMake(0, isPad?2:1);
		[self.view addSubview:l];
		
	}
	
    //	[self.view addSubview:instructionB];
    
	[self.view addSubview:supportB];
	[self.view addSubview:recommendB];
	[self.view addSubview:aboutB];
	
    
	if (kVersion>=5.0) {
		[self.view addSubview:twitterB];
	}
    //
	//---------------- binder right
	
	binder = [[UIImageView alloc]initWithFrame:CGRectMake(0.18 * _w, 0, isPad?72:30, _h)];
	binder.image = [UIImage imageWithContentsOfFileUniversal:@"Info_binder.png"];
	
	NSArray *moreAppNames;
	if (isPad) {
		moreAppNames = @[@"myecard",@"everalbum",@"tinykitchen"];
	}

	
	NSString *moreAppsPlistPath = [[NSBundle mainBundle] pathForResource:@"MoreApps.plist" ofType:nil];
	NSDictionary *moreAppsDict = [NSDictionary dictionaryWithContentsOfFile:moreAppsPlistPath];
	moreApps = [NSMutableArray array];
	for (NSString *name in moreAppNames) {
		MoreApp *app = [[MoreApp alloc]initWithName:name dictionary:moreAppsDict[name]];
		[moreApps addObject:app];
	}
    
	CGFloat wRibbon = isPad?25:11;
	ribbon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, wRibbon, wRibbon)];
	ribbon.image = [UIImage imageWithContentsOfFileUniversal:@"Info_selected.png"];
    
	
	scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.28* _w, (isPad?0.05:0.05)* _h, 0.67 * _w, 0.2 * _h)];
	scrollView.clipsToBounds = YES;
	scrollView.showsHorizontalScrollIndicator = NO;
    //	scrollView.backgroundColor = [UIColor redColor];
	
	CGFloat sVMargin = 0.05*scrollView.height;
	CGFloat sButtonWidth = 0.8*scrollView.height;
	CGFloat sHorizontMargin = (scrollView.width-3*sButtonWidth)/5;
	for (int i = 0; i<[moreApps count]; i++) {
        
		UIButton *b = [UIButton buttonWithFrame:CGRectMake(20+(sHorizontMargin+sButtonWidth)*i, sVMargin, sButtonWidth, sButtonWidth) title:nil image:nil target:self action:@selector(buttonClicked:)];
		[b setImage:[UIImage imageWithContentsOfFileUniversal:[moreApps[i] imgName]] forState:UIControlStateNormal];
		b.tag = i+1;
		b.layer.shadowColor = [UIColor colorWithWhite:0.2 alpha:0.8].CGColor;
		b.layer.shadowOpacity = 1;
		b.layer.shadowOffset = isPad?CGSizeMake(3, 3):CGSizeMake(1, 1);
		b.layer.shadowRadius = 1;
		
		[scrollView addSubview:b];
		[scrollView setContentSize:CGSizeMake(CGRectGetMaxX(b.frame)+200, 0)];
		
		if (i == 0) {
			firstAppB = b;
		}
	}
    
	//App Description TextView
	otherAppL = [[UILabel alloc]initWithFrame:CGRectMake(0.28* _w, CGRectGetMaxY(scrollView.frame)+(isPad?30:14), 0.67* _w, 0.1 * _h)];
	otherAppL.textAlignment = UITextAlignmentCenter;
	otherAppL.backgroundColor = [UIColor colorWithHEX:@"6c675f"];
	otherAppL.font = [UIFont fontWithName:kFontName size:isPad?50:21];
	otherAppL.textColor = [UIColor whiteColor];
	otherAppL.userInteractionEnabled = YES;
	otherAppL.shadowColor = [UIColor colorWithWhite:0 alpha:0.8];
	otherAppL.shadowOffset = CGSizeMake(0, isPad?4:2);
    
	
	CGFloat dBWidth = isPad?150:75;
	CGFloat dBHeight = isPad?50:25;
	CGFloat yDownloadBMargin = 10*faktor;
	downloadB = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(otherAppL.bounds)-dBWidth-5, yDownloadBMargin, dBWidth, dBHeight) title:nil image:nil target:self action:@selector(appstore)];
	[downloadB setImage:[UIImage imageWithContentsOfFileUniversal:@"Icon_AppstoreDownload.png"] forState:UIControlStateNormal];
	downloadB.center = CGPointMake(CGRectGetMaxX(otherAppL.bounds)-dBWidth/2-5 , otherAppL.height/2);
	downloadB.layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.8].CGColor;
	downloadB.layer.shadowOpacity = 1;
	downloadB.layer.shadowOffset = isPad?CGSizeMake(2, 2):CGSizeMake(1, 1);
	downloadB.layer.cornerRadius = isPad?5:3;
	downloadB.layer.borderWidth = 2;
	downloadB.layer.borderColor = [UIColor whiteColor].CGColor;
	
	[otherAppL addSubview:downloadB];
	
    
	textV = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMinX(otherAppL.frame), CGRectGetMaxY(otherAppL.frame), otherAppL.width, 0.54 * _h)];
	textV.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
	textV.textColor = [UIColor colorWithHEX:@"4d4e53"];
	textV.font = [UIFont boldSystemFontOfSize:isPad?22:11];
	textV.editable = NO;
	
	
	
	[self.view addSubview:textV];
	[self.view addSubview:otherAppL];
	[self.view addSubview:scrollView];
	[self.view addSubview:binder];
	[self.view addSubview:backB];
	
	[self buttonClicked:firstAppB];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (IBAction)buttonClicked:(UIButton*)sender{
    selectedIndex = sender.tag - 1;
    MoreApp *app = moreApps[selectedIndex];
    
    ribbon.frame = CGRectMake(sender.center.x-ribbon.width/2, CGRectGetMaxY(sender.frame)-(isPad?5:1), ribbon.width, ribbon.height);
    
	[scrollView insertSubview:ribbon belowSubview:sender];
	
	textV.text = app.description;
	otherAppL.text = app.title;
	[textV setContentOffset:CGPointMake(0, 0)];
}
- (void)facebook{
	
    [[FBViewController sharedInstance]feed];
}

@end
