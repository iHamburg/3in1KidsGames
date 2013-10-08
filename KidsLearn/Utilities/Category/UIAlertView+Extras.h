//
//  UIAlertView+Extras.h
//  Supercry
//
//  Created by AppDevelopper on 17.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIAlertView (UIAlertView_Extras)

+ (void)showAlert:(NSString*)title msg:(NSString*)msg;
+ (void)showAlert:(NSString*)title msg:(NSString*)msg cancel:(NSString*)cancel;
@end
