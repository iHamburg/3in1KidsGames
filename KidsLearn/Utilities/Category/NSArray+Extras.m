//
//  NSArray+Extras.m
//  KidsLearn
//
//  Created by  on 05.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "NSArray+Extras.h"

@implementation NSArray (Extras)


- (id)arrayWithRandom:(int)number{
	NSAssert(number<=[self count], @"number too much");

	NSMutableArray *array = [NSMutableArray arrayWithArray:self];
	
	while ([array count]>number) {
		[array removeObjectAtIndex:arc4random()%[array count]];
	}
	
	//
	[array sortUsingFunction:randomSort context:nil];
	
	return array;
	
}

int randomSort(id obj1, id obj2, void *context ) {
	// returns random number -1 0 1
	return (arc4random()%3 - 1);   
}

@end
