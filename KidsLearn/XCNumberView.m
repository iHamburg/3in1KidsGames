//
//  XCNumberView.m
//  KidsLearn
//
//  Created by XC on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XCNumberView.h"

@implementation XCNumberView


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
 
    NSLog(@"tag:%d clicked",tag-1);
    // 交给C
    [chooseVC numberClicked:tag-1];
    

}


@end
