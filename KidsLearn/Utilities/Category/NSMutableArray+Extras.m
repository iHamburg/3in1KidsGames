//
//  NSMutableArray+Extras.m
//  NR
//
//  Created by  on 16.05.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "NSMutableArray+Extras.h"

@implementation NSMutableArray (Extras)

- (void)addInt:(int)aInt{

	
	[self addObject:[NSString stringWithFormat:@"%d",aInt]];
}
- (void)addFloat:(float)aFloat{

	[self addObject:[NSString stringWithFormat:@"%f",aFloat]];
}
@end
