//
//  SpriteManager.h
//  SportTraining
//
//  Created by  on 10.03.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Utilities.h"



@interface SpriteManager : NSObject{
	
}


+(id)sharedInstance;

- (NSDictionary*)infoDictWithKey:(NSString*)key;

+ (UIImage*)numberImgWithIndex:(int)numIndex;

+ (UIImage*)colorImgWithIndex:(int)colorIndex;
+ (NSArray*)colorSpriteNamesWithIndex:(int)colorIndex;
+ (UIImage*)colorImgRandomWithIndex:(int)colorIndex;
+ (UIImage*)colorCanImgWithIndex:(int)colorIndex;
+ (NSArray*)imgNamesInShapeTestWithIndex:(int)shapeIndex;

+ (NSArray*)spriteNamesForNumberRoleCallView;

@end
