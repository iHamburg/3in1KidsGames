//
//  NSString+Extras.m
//  GoBeepItZXing
//
//  Created by AppDevelopper on 13.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSString+Extras.h"


@implementation NSString (NSString_Extras)

+ (NSString*)stringWithInt:(int)i{
    return [NSString stringWithFormat:@"%d",i];
}


+ (NSString*)stringWithFloat:(float)f{
    return [NSString stringWithFormat:@"%.2f",f];
}



+ (NSString*)dataFilePath:(NSString*)fileName{
	
	NSLog(@"fileName:%@",fileName);
	NSArray *paths = NSSearchPathForDirectoriesInDomains(
														 NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSString* myPlistPath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
	
	NSString *name = [fileName stringByDeletingPathExtension];
	NSString *pathExtension = [fileName pathExtension];
	
	NSString* path = [[NSBundle mainBundle] pathForResource:name ofType:pathExtension];
	
	// If it's not there, copy it from the bundle
	NSError *error;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if ( ![fileManager fileExistsAtPath:myPlistPath] && [fileManager fileExistsAtPath:path]) {
		//NSLog(@"copy begin, %@,to,%@",path,myPlistPath);
		if(![fileManager copyItemAtPath:path toPath:myPlistPath error:&error])
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", fileName);
	}       
    else{
        
    }

	
	return myPlistPath;
}


+ (NSString*)filePathForResource:(NSString*)fileName{
	NSString *name = [fileName stringByDeletingPathExtension];
	NSString *pathExtension = [fileName pathExtension];
	
	NSString* path = [[NSBundle mainBundle] pathForResource:name ofType:pathExtension];
	return path;

}
@end
