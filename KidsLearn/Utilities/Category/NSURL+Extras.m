//
//  NSURL+Extras.m
//  FirstThings_Uni
//
//  Created by  on 11.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "NSURL+Extras.h"

@implementation NSURL (Extras)

+ (id)urlWithResourceName:(NSString*)name type:(NSString*)type{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
	
    NSURL *temp = [[NSURL alloc] initFileURLWithPath:path];
	return temp;
}

+ (id)urlWithFilename:(NSString*)name{
	NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:nil];
	return [[NSURL alloc] initFileURLWithPath:path];
}
@end
