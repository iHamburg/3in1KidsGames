//
//  AdView.m
//  MyeCard
//
//  Created by AppDevelopper on 02.02.13.
//
//

#import "AdView.h"
#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

NSString *const NotificationAdChanged = @"ADChanged";

@interface AdView()

- (void)setupIAD;
- (void)setupGAD;

@end

@implementation AdView


static bool _isIAD = NO;
static bool _iadAvailable = NO;

static bool _isGADLoaded = NO;

static NSString *MY_BANNER_UNIT_ID=@"a15226a64014da4";   //iCA
//static NSString *MY_BANNER_UNIT_ID=@"a1510c1a0d38138"; // Everalbum
//static NSString *MY_BANNER_UNIT_ID=@"a1510e69df21727"; // TinyKitchen


@synthesize isAdDisplaying;

- (void)setIsAdDisplaying:(BOOL)isAdDisplaying_{
    isAdDisplaying = isAdDisplaying_;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationAdChanged object:self];
}

- (BOOL)bannerLoaded{
	if (_isIAD) {
		return _iadView.bannerLoaded;
	}
	else{
		return _isGADLoaded;
	}
    
}

#pragma mark -
static id sharedInstance;

+(id)sharedInstance{

    if (isPaid() || isIAPFullVersion) {
        return nil;
    }
    
    if (sharedInstance == nil) {
		
		sharedInstance = [[[self class] alloc]initWithFrame:CGRectMake(0, 0, _w, _hAdBanner)];
	}
	
	return sharedInstance;
	
}


+(void)releaseSharedInstance{

    sharedInstance = nil;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ADChanged" object:nil];
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(handleResignActive)
													 name:UIApplicationWillResignActiveNotification
												   object:nil];

		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(handleBecomeActive)
													 name:UIApplicationDidBecomeActiveNotification
												   object:nil];

		
		static NSSet* supportedCountries = nil;
		if (supportedCountries == nil)
		{
			supportedCountries = [NSSet setWithObjects:
								  @"ES", // spain
								  @"US", // usa
								  @"UK", // united kingdom
								  @"CA", // canada
								  @"FR", // france
								  @"DE", // german
								  @"IT", // italy
								  @"JP", // japan
								  nil];
		}
		
		NSLocale* currentLocale = [NSLocale currentLocale];  // get the current locale.
		NSString* countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
		NSLog(@"contryCode # %@",countryCode);
		
		if ([supportedCountries containsObject:countryCode]) {
			_iadAvailable = YES;
		}
		else{
			_iadAvailable = NO;
		}
		
		// 优先调用IAD
		
		
		if (_iadAvailable) { // iad

			[self setupIAD];
		}
		else{ //gad
			[self setupGAD];
		}
		
		// 开始时hidden，等到载入iad时才显示
//		self.hidden = YES;
	

    }
    return self;
}

-(void)dealloc{
    
}

- (void)handleResignActive{
//	L();
	
	
}

- (void)handleBecomeActive{
//	L();

//	[[ViewController sharedInstance] initBanner];
}
#pragma mark - iAD Banner


- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
	L();

//	self.hidden = NO;
	
	self.isAdDisplaying = YES;
	
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
	//	L();
	NSLog(@"error # %@",[error localizedDescription]);

//	self.hidden= YES;
	
	self.isAdDisplaying = NO;

	//iad fail 自动调用 admob
	[self setupGAD];
	
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
	
	
    return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
	L();
	
}


#pragma mark - Google Admob Ads
// Sent when an ad request loaded an ad.  This is a good opportunity to add this
// view to the hierarchy if it has not yet been added.  If the ad was received
// as a part of the server-side auto refreshing, you can examine the
// hasAutoRefreshed property of the view.
- (void)adViewDidReceiveAd:(GADBannerView *)view {
	//	[self.view addSubview:gAdView];
	//    is_gAdFailed = NO;
	//    is_gAdON = YES;
	//
	//    isAdLoaded = YES;
	L();
	
	_isGADLoaded = YES;
	
//	self.hidden = NO;

	self.isAdDisplaying = YES;
//	[[NSNotificationCenter defaultCenter]postNotificationName:kNotificationLoadAdview object:self];
	
	
}

// Sent when an ad request failed.  Normally this is because no network
// connection was available or no ads were available (i.e. no fill).  If the
// error was received as a part of the server-side auto refreshing, you can
// examine the hasAutoRefreshed property of the view.
- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
   
	NSLog(@"GAD error # %@", [error description]);
	
	_isGADLoaded = NO;
	
//	self.hidden = YES;
	
	self.isAdDisplaying = NO;

	///TODO: 当GAD不能调用，继续尝试
	[self setupGAD];
}

// Sent just before presenting the user a full screen view, such as a browser,
// in response to clicking on an ad.  Use this opportunity to stop animations,
// time sensitive interactions, etc.
//
// Normally the user looks at the ad, dismisses it, and control returns to your
// application by calling adViewDidDismissScreen:.  However if the user hits the
// Home button or clicks on an App Store link your application will end.  On iOS
// 4.0+ the next method called will be applicationWillResignActive: of your
// UIViewController (UIApplicationWillResignActiveNotification).  Immediately
// after that adViewWillLeaveApplication: is called.
- (void)adViewWillPresentScreen:(GADBannerView *)adView {
    NSLog(@"[GAD]: 即将显示全屏广告.");
}

// Sent just before dismissing a full screen view.
- (void)adViewWillDismissScreen:(GADBannerView *)adView {
    NSLog(@"[GAD]: 即将退出全屏广告.");
}

// Sent just after dismissing a full screen view.  Use this opportunity to
// restart anything you may have stopped as part of adViewWillPresentScreen:.
- (void)adViewDidDismissScreen:(GADBannerView *)adView {
    NSLog(@"[GAD]: 全屏广告已经退出.");
}

// Sent just before the application will background or terminate because the
// user clicked on an ad that will launch another application (such as the App
// Store).  The normal UIApplicationDelegate methods, like
// applicationDidEnterBackground:, will be called immediately before this.
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    NSLog(@"[GAD]: 即将进入广告目标.");
}

#pragma mark -

- (void)setupIAD{
	L();
	if ([ADBannerView instancesRespondToSelector:@selector(initWithAdType:)]) {
		_iadView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
		
	}
	else {
		_iadView = [[ADBannerView alloc] init];
	}
	_iadView.delegate = self;
	_iadView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
	
	[self addSubview:_iadView];
	
	_isIAD = YES;
	[_gadView removeFromSuperview];
	_gadView.delegate = nil;
	_gadView = nil;
	
}

- (void)setupGAD{
	L();

	_gadView = [[GADBannerView alloc]initWithAdSize:kGADAdSizeSmartBannerLandscape origin:CGPointZero];
	
	//设置阴影
	_gadView.layer.shadowOffset = CGSizeMake(5, 3);
	_gadView.layer.shadowOpacity = 0.9;
	_gadView.layer.shadowColor = [UIColor grayColor].CGColor;
	
	_gadView.adUnitID = MY_BANNER_UNIT_ID;
	_gadView.rootViewController = [ViewController sharedInstance];
	
	_gadView.delegate = self;
	[_gadView loadRequest:[GADRequest request]];
	
	[self addSubview:_gadView];
	
	_isIAD = NO;
	[_iadView removeFromSuperview];
	_iadView.delegate = nil;
	_iadView = nil;
	
}



@end
