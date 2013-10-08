//
//  NSURL+Extras.h
//  FirstThings_Uni
//
//  Created by  on 11.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Extras)

+ (id)urlWithResourceName:(NSString*)name type:(NSString*)type;
+ (id)urlWithFilename:(NSString*)name;
@end
