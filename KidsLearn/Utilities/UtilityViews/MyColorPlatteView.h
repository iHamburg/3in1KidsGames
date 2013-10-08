//
//  ColorPlatteView.h
//  XappCard
//
//  Created by  on 06.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyColorPlatteDelegate;

@interface MyColorPlatteView : UIView{
	
	BOOL landscape;
}


@property (nonatomic, unsafe_unretained) id<MyColorPlatteDelegate> delegate;

- (void)initSubviews;


@end

@protocol MyColorPlatteDelegate <NSObject>

- (void)colorPlatte:(MyColorPlatteView*)v didTapColor:(UIColor*)color;

@end