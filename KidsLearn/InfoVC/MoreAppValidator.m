//
//  MoreAppValidator.m
//  3in1KidsGames
//
//  Created by AppDevelopper on 13-10-22.
//
//

#import "MoreAppValidator.h"
#import "InfoViewController.h"
#import "ExportController.h"

@implementation MoreAppValidator

- (id)initWithViewController:(InfoViewController*)vc{
    if (self = [self init]) {
        selectedAppID = vc.selectedAppID;
    }
    
    return self;
}

- (void)execute{
    
    NSLog(@"appid # %@",selectedAppID);
    
  [[ExportController sharedInstance]linkToAppStoreWithID:selectedAppID];
}

@end
