//
//  SpriteManager.m
//  SportTraining
//
//  Created by  on 10.03.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "SpriteManager.h"



@interface SpriteManager() {

    
}

@end

@implementation SpriteManager

static NSDictionary *spriteDict;

+(id)sharedInstance{
	static id sharedInstance;
	if (sharedInstance == nil) {
		
		sharedInstance = [[[self class] alloc]init];
	}
	
	return sharedInstance;
	
}

- (id)init{
	if (self = [super init]) {
		NSString* spriteDictPath = [[NSBundle mainBundle]pathForResource:@"Sprite" ofType:@"plist"];
		spriteDict = [NSDictionary dictionaryWithContentsOfFile:spriteDictPath];
		
	}
	return self;
}

#pragma mark -
- (NSDictionary*)infoDictWithKey:(NSString*)key{
	return [spriteDict objectForKey:key];
}

+ (UIImage*)numberImgWithIndex:(int)numIndex{
	
	return [UIImage imageNamed:[NSString stringWithFormat:@"Button_%d.png",numIndex+1]];
}

+ (UIImage*)colorImgWithIndex:(int)colorIndex{
	
	NSArray *colorImgNames = [spriteDict valueForKeyPath:@"Color.ColorImgs"];
//	NSLog(@"colorImgs:%@",colorImgName);
	
	return [UIImage imageNamed:[colorImgNames objectAtIndex:colorIndex]];
}

+ (UIImage*)colorCanImgWithIndex:(int)colorIndex{
    
    NSArray *colorImgNames = [spriteDict valueForKeyPath:@"Color.ColorCanImgs"];
    //	NSLog(@"colorImgs:%@",colorImgName);
	
	return [UIImage imageNamed:[colorImgNames objectAtIndex:colorIndex]];
}

+ (NSArray*)colorSpriteNamesWithIndex:(int)colorIndex{
	NSArray *colorSprites = [spriteDict valueForKeyPath:@"Color.ColorSprites"];
	
	return [colorSprites objectAtIndex:colorIndex];
}
+ (UIImage*)colorImgRandomWithIndex:(int)colorIndex{
	NSArray *colorSprites = [spriteDict valueForKeyPath:@"Color.ColorSprites"];
    
    
	NSArray *imgNames = [colorSprites objectAtIndex:colorIndex];
//	NSLog(@"imgNames:%@",imgNames);
	UIImage *img = [UIImage imageNamed:[imgNames objectAtIndex:arc4random()%[imgNames count]]];
	return img;
}

+ (NSArray*)imgNamesInShapeTestWithIndex:(int)shapeIndex{
	NSArray *shapeTests = [spriteDict valueForKeyPath:@"Shape.Test"];
	return [shapeTests objectAtIndex:shapeIndex];
}

+ (NSArray*)spriteNamesForNumberRoleCallView{
	return [spriteDict valueForKeyPath:@"Number.NumberRoleCallPlayView.spriteNames"];
}
@end
