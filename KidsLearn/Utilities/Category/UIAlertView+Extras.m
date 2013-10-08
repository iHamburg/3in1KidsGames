//
//  UIAlertView+Extras.m
//  Supercry
//
//  Created by AppDevelopper on 17.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIAlertView+Extras.h"


@implementation UIAlertView (UIAlertView_Extras)

+ (void)showAlert:(NSString*)title msg:(NSString*)msg{
               
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                                message:msg
                                                               delegate:nil
                                                      cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:nil];
[alert show];

}

+ (void)showAlert:(NSString*)title msg:(NSString*)msg cancel:(NSString*)cancel{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:cancel
                                          otherButtonTitles:nil];
    [alert show];

}
@end
