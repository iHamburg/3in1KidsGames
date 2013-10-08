//
//  XCShapeViewController.h
//  KidsLearn
//
//  Created by XC on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XCLearnViewController.h"
#import "XCShapeView.h"

@interface XCShapeViewController : XCLearnViewController<ShapeViewDelegate>{
	
 	IBOutlet XCShapeView *shapeV;
	
	NSArray *playClassNames;
	NSArray *testClassNames;
}

- (void)toTest:(Shape)shapeIndex;
@end
