//
//  XCTestView.m
//  KidsLearn
//
//  Created by  on 18.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "XCTestView.h"

@implementation XCTestView

@synthesize  selectedIndex, testIndex,testNumberIndex;
@synthesize vc;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		[self load];
	}
    return self;
}

- (void)awakeFromNib{
//	L();
	[self load];
}
- (void)load{
	
	size = self.bounds.size;
	
	bgV = [[UIImageView alloc] initWithFrame:self.bounds];
	bgV.autoresizingMask = kAutoResize;

	
	sprites = [NSMutableArray array];

	controlV = [[ControlView alloc]initWithFrame:self.bounds];
	controlV.delegate = self;
	[self addSubview:bgV];

	[self addSubview:controlV];
}
- (void)setup{
	
}

- (void)setSelectedIndex:(int)_selectedIndex{
	selectedIndex = _selectedIndex;
	[self setup];
}

- (void)startCorrectAnimating{
	
}
- (void)startWrongAnimating{

}

@end
