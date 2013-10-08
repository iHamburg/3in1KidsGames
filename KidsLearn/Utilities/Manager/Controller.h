//
//  Controller.h
//  SportTraining
//
//  Created by  on 10.03.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>

#import "Utilities.h"

#import "UtilityViews.h"
#import "Manager.h"

#import "FBViewController.h" //Facebook
//#import "FlurryAnalytics.h"  //Flurry

@interface Controller : NSObject{

	NSArray *colors;
	NSArray *foodNames;
	
	
}

+(id)sharedInstance;

@property (nonatomic, assign) SpielMode mode;


- (UIColor*)colorWithIndex:(int)index;
- (UIImage*)foodImageForNumberTest;
- (UIImage *)makeImageBW:(UIImage*)img;

@end
