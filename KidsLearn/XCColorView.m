//
//  XCColorView.m
//  KidsLearn
//
//  Created by XC on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XCColorView.h"

@implementation XCColorView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
#pragma mark - IBAction

- (IBAction)buttonClicked:(id)sender{
    int tag = [sender tag];
    
    NSLog(@"tag:%d clicked",tag);
	
	[delegate colorClicked:tag-11];
}
@end
