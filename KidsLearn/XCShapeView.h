//
//  XCShapeView.h
//  KidsLearn
//
//  Created by XC on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Controller.h"

@protocol  ShapeViewDelegate;

@interface XCShapeView : UIView{
   
}

- (void)load;

@property (nonatomic, assign) CGPoint drawOrigin;
@property (nonatomic, assign) UIColor *strokeColor;
@property (nonatomic, unsafe_unretained) IBOutlet id<ShapeViewDelegate> delegate;

@end

@protocol ShapeViewDelegate <NSObject>

- (void) shapeView:(XCShapeView*)shapeView didClickShape:(Shape)shape;

@end
