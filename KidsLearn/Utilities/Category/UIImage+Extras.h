//
//  UIImage+Extras.h
//  Supercry
//
//  Created by AppDevelopper on 14.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//#import "UIImage+Alpha.h"

@interface UIImage (Extras)

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;
- (UIImage*)imageByScalingAndCroppingForWidth:(float)width;
- (UIImage*)imageByScaleingWithMinLength:(CGFloat)minLength; // if minLength=320, 960x640->480x320, 100x100 不变
- (UIImage*)imageByScaleingWithMaxLength:(CGFloat)maxLength;
- (UIImage*)imageByCroppedPath:(UIBezierPath*)path;


- (UIImage*)rotate:(UIImageOrientation)orient;



//+ (UIImage*)createRoundedRectImage:(UIImage*)image size:(CGSize)size;

+ (UIImage*)imageWithView:(UIView*)view;
+ (UIImage*)imageWithView:(UIView*)view scale:(CGFloat)scale;


/**
 
 1. 一定要有aaa.jpg, 才能自动载入aaa@2x.jpg ???
 2. 如果没有～ipad的图片，会自动调用iphone的图片，可是pad不会调用iphone@2x的图片，只会调用iphone的图片
 3. 如果没有iphone的图片，不会调用~ipad的图片
 
 */
+ (UIImage*)imageWithContentsOfFileName:(NSString *)fileName;

/**
 
 imageWithContentsOfFile + fileName~ipad.extension
 
 aaa~ipad.jpg & aaa@2x~ipad.jpg的好处是： 
 1. iphoneR,ipad 都能调用一张图片，ipad没有降格
 
 问题：
 1. iphoneR的scale不对，调整一下？
 
 */
+ (UIImage*)imageWithContentsOfFileUniversal:(NSString *)fileName;  //TODO: 说明

/**
 
 图片名：aaa~ipad.jpg, aaa@2x~ipad.jpg
 */
+ (UIImage*)imageNamedUniversal:(NSString*)name __deprecated;


/**
 
 imageWithContentsOfFileUniversal + NSData
 
 */
+ (UIImage*)imageWithSystemName:(NSString*)fileName; //图片名或者NSData file @"bg.jpg" or @"albumname_momentname_preview", 返回的image，scale都是1？

/**
  使用library的bundle中的图片
 */
+ (UIImage*)imageWithContentsOfBundleFile:(NSString*)fileName; // bundle: utilLib.bundle


//+ (UIImage*)imageWithCacheName:(NSString*)fileName;

//- (void)saveWithName:(NSString*)fileName;//save under documents
//- (void)savePNGWithName:(NSString*)fileName;

@end
