//
//  AnimationiManager.m
//  KidsLearn
//
//  Created by  on 26.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "AnimationiManager.h"

@implementation AnimationiManager

// 左右晃动
+ (void)waver:(UIView*)v{
	[UIView animateWithDuration:0.5 animations:^{ // waffe right
		[v moveOrigin:CGPointMake(20, 0)];
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:0.5 animations:^{ // waffe left
			[v moveOrigin:CGPointMake(-40, 0)];
		} completion:^(BOOL finished) {
			[UIView animateWithDuration:0.5 animations:^{ // waffe right
				[v moveOrigin:CGPointMake(20, 0)];
			} completion:^(BOOL finished) {
				
			}];
		}];
	}];

}

// 放大缩小
+ (void)scale:(UIView*)v withScale:(CGFloat)scale times:(int)times{
	[UIView animateWithDuration:0.5 animations:^{ // 缩小
		v.transform = CGAffineTransformMakeScale(scale, scale);

	} completion:^(BOOL finished) {
		[UIView animateWithDuration:0.5 animations:^{ //放大
			v.transform = CGAffineTransformMakeScale(1, 1);
				
		} completion:^(BOOL finished) {
			if (!finished || times<=1) {
				return;
			}
			
			[UIView animateWithDuration:0.5 animations:^{ // 缩小
				v.transform = CGAffineTransformMakeScale(scale, scale);
		
			} completion:^(BOOL finished) {
				[UIView animateWithDuration:0.5 animations:^{ //放大
					v.transform = CGAffineTransformMakeScale(1, 1);

				} completion:^(BOOL finished) {
					
				}];
			}];
			
		}];
	}];

}

+ (void)move:(UIView*)v away:(CGPoint)point{
	[UIView animateWithDuration:0.5 animations:^{
		[v moveOrigin:point];
	} completion:^(BOOL finished) {
		
	}];
}

+ (void)clickAnimation:(UIView*)v{
	[UIView animateWithDuration:0.25 animations:^{ // 缩小
		v.transform = CGAffineTransformMakeScale(1.2, 1.2);
		
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:0.25 animations:^{ //放大
			v.transform = CGAffineTransformMakeScale(1, 1);
			
		}];		
	
	}];
}
+ (void)jump:(UIView*)v{
//    v.transform = CGAffineTransformMakeScale(0.8, 0.8);
    [UIView animateWithDuration:0.3 animations:^{
//        v.transform = CGAffineTransformMakeScale(1.0, 1.0);
        [v moveOrigin:CGPointMake(0, -40)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            [v moveOrigin:CGPointMake(0, 40)];
        } completion:^(BOOL finished) {
            
        }];
    }];
}

+ (void)jumps:(NSArray*)vs{
    [UIView animateWithDuration:0.3 animations:^{
        for (UIView *v in vs) {
              [v moveOrigin:CGPointMake(0, -40)];
        }
      
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            for (UIView *v in vs) {
                [v moveOrigin:CGPointMake(0, +40)];
            }
        } ];
    }];

}
+ (void)rotate:(UIView*)v{
	
	[UIView animateWithDuration:0.25 animations:^{
		v.transform = CGAffineTransformMakeRotation(degreesToRadians(15.0));
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:0.5 animations:^{
			v.transform = CGAffineTransformMakeRotation(degreesToRadians(-15.0));
		} completion:^(BOOL finished) {
			[UIView animateWithDuration:0.5 animations:^{
				v.transform = CGAffineTransformMakeRotation(0);
			} completion:^(BOOL finished) {
				
			}];
		}];
	}];
}
@end
