//
//  CustomBarButtonItem.h
//  XappCard
//
//  Created by  on 02.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomBarButtonItem : UIBarButtonItem
- (id) initWithImage:(UIImage *)image title:(NSString *)title target:(id)target action:(SEL)action;

- (id) initWithImage2:(UIImage *)image title:(NSString *)title target:(id)target action:(SEL)action;
@end


@interface UIBarButtonItem (CustomBarButtonItem)

+ (UIBarButtonItem *) barButtonItemWithImage:(UIImage *)image title:(NSString *)title target:(id)target action:(SEL)action;

@end
