//
//  Macros.h
//  Xappsoft
//
//  Created by Michael Zapf on 27.05.11.
//  Copyright 2011 Xappsoft. All rights reserved.
//

#define LString(x) NSLocalizedString(x, nil)

#define GetFullPath(_filePath_) [[NSBundle mainBundle] pathForResource:[_filePath_ lastPathComponent] ofType:nil inDirectory:[_filePath_ stringByDeletingLastPathComponent]]


#define ISEMPTY(x)	(((x) == nil ||[(x) isKindOfClass:[NSNull class]] ||([(x) isKindOfClass:[NSString class]] &&  [(NSString*)(x) length] == 0) || ([(x) isKindOfClass:[NSArray class]] && [(NSArray*)(x) count] == 0))|| ([(x) isKindOfClass:[NSDictionary class]] && [(NSDictionary*)(x) count] == 0))

#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isLandscape [UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeLeft||[UIDevice currentDevice].orientation==UIInterfaceOrientationLandscapeRight
#define isPortrait [UIDevice currentDevice].orientation == UIDeviceOrientationPortraitUpsideDown||[UIDevice currentDevice].orientation==UIDeviceOrientationPortrait

#define isIAPFullVersion [[NSUserDefaults standardUserDefaults] boolForKey:kIAPFullVersion]
#define isRetina [[UIScreen mainScreen] scale] != 1.0f

#define ROUND(x)	(round((x)*10)/10.0)

#define degreesToRadians(x) ((x)/180.0f*M_PI)

#define TRANSFORM(degree) CGAffineTransformMakeRotation(M_PI*(degree)/180.0);

#define kVersion [[[UIDevice currentDevice] systemVersion] floatValue]

#define kAutoResize UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin

#pragma mark - Debug & Release


#ifdef DEBUG

#define LocLogEnd() NSLog(@"%s End",__FUNCTION__)
#define L() NSLog(@"%s",__FUNCTION__)

#else

#define LocLogEnd()
#define L()

#endif

#pragma mark -

#define kNewLine @"\r\n"

