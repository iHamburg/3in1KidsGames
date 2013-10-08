//
//  NSString+Extras.h
//  GoBeepItZXing
//
//  Created by AppDevelopper on 13.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (NSString_Extras)

//- (UIColor*)colorFromHex;

+ (NSString*)stringWithInt:(int)i;

+ (NSString*)stringWithFloat:(float)f;



+ (NSString*)dataFilePath:(NSString*)fileName;


+ (NSString*)filePathForResource:(NSString*)fileName;

@end
