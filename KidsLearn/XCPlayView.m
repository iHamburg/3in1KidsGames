//
//  XCPlayView.m
//  KidsLearn
//
//  Created by  on 18.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "XCPlayView.h"

@implementation XCPlayView

@synthesize selectedIndex,vc;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		[self load];
		
		// 背景图片
	    }
    return self;
}

- (void)awakeFromNib{
	[self load];
}
- (void)load{
	
	size = self.bounds.size;
	
	sprites = [NSMutableArray array];
	playSprites = [NSArray array];
	
	bgV = [[UIImageView alloc] initWithFrame:self.bounds];
	
	[self addSubview:bgV];

	

}
- (void)setup{
	
	
}
- (void)play{
	
	
}
- (void)setSelectedIndex:(int)_selectedNumber{
	selectedIndex = _selectedNumber;
	
	[self setup];
}

#pragma mark - IBOutlet
- (IBAction)buttonClicked:(id)sender{
	
}
@end
