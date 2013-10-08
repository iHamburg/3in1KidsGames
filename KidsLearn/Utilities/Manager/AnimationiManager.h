//
//  AnimationiManager.h
//  KidsLearn
//
//  Created by  on 26.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utilities.h"

@interface AnimationiManager : NSObject

+ (void)waver:(UIView*)v;
+ (void)scale:(UIView*)v withScale:(CGFloat)scale times:(int)times;
+ (void)move:(UIView*)v away:(CGPoint)point;
+ (void)clickAnimation:(UIView*)v;
+ (void)jump:(UIView*)v;
+ (void)jumps:(NSArray*)vs;
+ (void)rotate:(UIView*)v;

@end
