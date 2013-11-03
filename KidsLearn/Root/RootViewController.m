//
//  RootViewController.m
//  iCamAlbum
//
//  Created by AppDevelopper on 13-10-11.
//  Copyright (c) 2013年 Xappsoft. All rights reserved.
//

#import "RootViewController.h"

#define kFirstVersionKey @"firstVersionKey"
#define kLastVersionKey @"lastVersionKey"

@implementation RootViewController

+(id)sharedInstance{
	
	static id sharedInstance;
	
	if (sharedInstance == nil) {
		
		sharedInstance = [[[self class] alloc]init];
	}
	return sharedInstance;
	
}

- (void)checkVersion{
 

   CGFloat firstVersion = [[NSUserDefaults standardUserDefaults]floatForKey:kFirstVersionKey];
   CGFloat lastVersion = [[NSUserDefaults standardUserDefaults]floatForKey:kLastVersionKey];
   CGFloat thisVersion = [[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey] floatValue];
	
	if (firstVersion == 0.0) { // 第一次安装app
		isFirstOpen = YES;
		
		firstVersion =  [[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey] floatValue];
		[[NSUserDefaults standardUserDefaults]setFloat:firstVersion forKey:kFirstVersionKey];
		
		lastVersion = firstVersion;
		[[NSUserDefaults standardUserDefaults]setFloat:lastVersion forKey:kLastVersionKey];
		
	}
	else{ // 已经安装过app，再次打开
		if (thisVersion != lastVersion) {
			isUpdateOpen = YES;
		}
		
		[[NSUserDefaults standardUserDefaults]setFloat:thisVersion forKey:kLastVersionKey];
	}
	
	
    NSLog(@"firstVersion # %f, thisVersion # %f, isFirstOpen # %d",firstVersion,thisVersion,isFirstOpen);
}
//
- (void)loadView{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
														 NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"docuPath # %@",documentsDirectory);
    
	rootLoadViewFlag = YES;
    [self registerNotification];
    [self checkVersion];
}

- (void)handleAppFirstTimeOpen{
    
}
- (void)handleRootFirstDidAppear{
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (rootLoadViewFlag) {
        
        rootLoadViewFlag = NO;
        
		if (isFirstOpen) {
			
			[self handleAppFirstTimeOpen];
			
		}
		else if(isUpdateOpen){
			
		}
        
        [self handleRootFirstDidAppear];
//        [self loadAdView];
	}

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark -
- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleWillEnterForeground)
												 name:UIApplicationWillEnterForegroundNotification
											   object: [UIApplication sharedApplication]];
	
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleWillResignActive) name:UIApplicationWillResignActiveNotification object:[UIApplication sharedApplication]];
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(IAPDidFinished) name:kNotificationIAPFinish object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(IAPDidFinished) name:kNotificationIAPRestore object:nil];
}

- (void)handleWillEnterForeground{
	
    
}

- (void)handleWillResignActive{
    


}


#pragma mark - Info
- (void)infoVCWillClose:(InfoViewController *)infoVC{
    
}

#pragma mark - Instruction
- (void)instructionVCWillDismiss:(InstructionViewController *)vc{
    
}

#pragma mark - Intern Fcn

- (void)loadAdView {
    
    ///启动adview
    [AdView sharedInstance];
}

- (void)test{
    testObjs = [NSMutableArray array];
}

@end
