//
//  XCColorView.h
//  KidsLearn
//
//  Created by XC on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorViewDelegate;

@interface XCColorView : UIView{

}

@property (nonatomic, unsafe_unretained) IBOutlet id<ColorViewDelegate> delegate;
- (IBAction)buttonClicked:(id)sender;
@end

@protocol ColorViewDelegate <NSObject>

- (void)colorClicked:(int)colorIndex;

@end