//
//  UIImage+Extras.m
//  Supercry
//
//  Created by AppDevelopper on 14.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIImage+Extras.h"
#import "Macros.h"
#import <QuartzCore/QuartzCore.h>
#import "NSString+Extras.h"


static inline CGSize swapWidthAndHeight(CGSize size)
{
    CGFloat  swap = size.width;
    
    size.width  = size.height;
    size.height = swap;
    
    return size;
}
@implementation UIImage (Extras)

#pragma mark -
#pragma mark Scale and crop image
//
//static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
//                                 float ovalHeight)
//{
//    float fw, fh;
//    if (ovalWidth == 0 || ovalHeight == 0) {
//        CGContextAddRect(context, rect);
//        return;
//    }
//	
//    
//    CGContextSaveGState(context);
//    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
//    CGContextScaleCTM(context, ovalWidth, ovalHeight);
//    fw = CGRectGetWidth(rect) / ovalWidth;
//    fh = CGRectGetHeight(rect) / ovalHeight;
//    
//    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
//    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
//    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
//    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
//    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
//	
//    
//    CGContextClosePath(context);
//    CGContextRestoreGState(context);
//}
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;        
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) 
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor) 
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5; 
        }
        else 
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }       
    
//    UIGraphicsBeginImageContext(targetSize); // this will crop
    UIGraphicsBeginImageContextWithOptions(targetSize, NO, 0);
	
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) 
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage*)imageByScalingAndCroppingForWidth:(float)width{

    float oWidth = self.size.width;
    float oHeight = self.size.height;
    float height = width*oHeight/oWidth;
    
    CGSize targetSize = CGSizeMake(width, height);

    return [self imageByScalingAndCroppingForSize:targetSize];    
}


//960x640, min320->480x320,

- (UIImage*)imageByScaleingWithMinLength:(CGFloat)minLength{
	float scale = [UIScreen mainScreen].scale;
	float width = self.size.width;
    float height = self.size.height;
	
	
	// 如果原图最小边*scale(像素)《maxLength*scale(像素)
	if (MAX(width, height)*self.scale <= minLength*scale) {
		
		if (self.scale == scale) { //如果当前image的scale等于device的scale，不变形
			return self;
		}
		else{// 否则把image的scale更新到device的scale
			return [self imageByScalingAndCroppingForSize:CGSizeMake(width*self.scale/scale, height*self.scale/scale)];
		}
	}
	
	
	CGSize size;
	
	
	if (width>height) {
		size = CGSizeMake(width/height*minLength, minLength);
	}
	else{
		size = CGSizeMake(minLength, height/width*minLength);
	}
	return [self imageByScalingAndCroppingForSize:size];
}


// 960x640, max 480 ->480x320
- (UIImage*)imageByScaleingWithMaxLength:(CGFloat)maxLength{
	float scale = [UIScreen mainScreen].scale;
	
	float width = self.size.width;
    float height = self.size.height;
	
	// 如果原图最小边*scale(像素)《maxLength*scale(像素)
	if (MAX(width, height)*self.scale <= maxLength*scale) {
		
		if (self.scale == scale) { //如果当前image的scale等于device的scale，不变形
			return self;
		}
		else{// 否则把image的scale更新到device的scale
			return [self imageByScalingAndCroppingForSize:CGSizeMake(width*self.scale/scale, height*scale/scale)];
		}
	}
	
	CGSize size;
	
	
	if (width<height) {
		size = CGSizeMake(width/height*maxLength, maxLength);
	}
	else{
		size = CGSizeMake(maxLength, height/width*maxLength);
	}
	return [self imageByScalingAndCroppingForSize:size];
}



-(UIImage*)rotate:(UIImageOrientation)orient
{
    CGRect             bnds = CGRectZero;
    UIImage*           copy = nil;
    CGContextRef       ctxt = nil;
    CGRect             rect = CGRectZero;
    CGAffineTransform  tran = CGAffineTransformIdentity;
    
    bnds.size = self.size;
    rect.size = self.size;
    
    switch (orient)
    {
        case UIImageOrientationUp:
            return self;
            
        case UIImageOrientationUpMirrored:
            tran = CGAffineTransformMakeTranslation(rect.size.width, 0.0);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown:
            tran = CGAffineTransformMakeTranslation(rect.size.width,
                                                    rect.size.height);
            tran = CGAffineTransformRotate(tran, degreesToRadians(180.0));
            break;
            
        case UIImageOrientationDownMirrored:
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.height);
            tran = CGAffineTransformScale(tran, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeft:
            bnds.size = swapWidthAndHeight(bnds.size);
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.width);
            tran = CGAffineTransformRotate(tran, degreesToRadians(-90.0));
            break;
            
        case UIImageOrientationLeftMirrored:
            bnds.size = swapWidthAndHeight(bnds.size);
            tran = CGAffineTransformMakeTranslation(rect.size.height,
                                                    rect.size.width);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            tran = CGAffineTransformRotate(tran, degreesToRadians(-90.0));
            break;
            
        case UIImageOrientationRight:
            bnds.size = swapWidthAndHeight(bnds.size);
            tran = CGAffineTransformMakeTranslation(rect.size.height, 0.0);
            tran = CGAffineTransformRotate(tran, degreesToRadians(90.0));
            break;
            
        case UIImageOrientationRightMirrored:
            bnds.size = swapWidthAndHeight(bnds.size);
            tran = CGAffineTransformMakeScale(-1.0, 1.0);
            tran = CGAffineTransformRotate(tran, degreesToRadians(90.0));
            break;
            
        default:
            // orientation value supplied is invalid
            assert(false);
            return nil;
    }
    
    UIGraphicsBeginImageContext(bnds.size);
    ctxt = UIGraphicsGetCurrentContext();
    
    switch (orient)
    {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextScaleCTM(ctxt, -1.0, 1.0);
            CGContextTranslateCTM(ctxt, -rect.size.height, 0.0);
            break;
            
        default:
            CGContextScaleCTM(ctxt, 1.0, -1.0);
            CGContextTranslateCTM(ctxt, 0.0, -rect.size.height);
            break;
    }
    
    CGContextConcatCTM(ctxt, tran);
    CGContextDrawImage(ctxt, rect, self.CGImage);
    
    copy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return copy;
}

+ (UIImage*)imageWithView:(UIView*)view{
    
	UIGraphicsBeginImageContextWithOptions(view.bounds.size, 0, [[UIScreen mainScreen]scale]);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
	UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
    
	UIGraphicsEndImageContext();
	
	return aImage;
}


+ (UIImage*)imageWithView:(UIView*)view scale:(CGFloat)scale{
    
    NSLog(@"view # %@",view);
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, 0, scale);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
	UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
    
	UIGraphicsEndImageContext();
	
	return aImage;
}

+ (UIImage*)imageWithView:(UIView*)view faktor:(float)faktor{
	CGSize originSize = view.bounds.size;
	CGSize newSize = CGSizeMake(originSize.width * faktor, originSize.height * faktor);
	
	UIGraphicsBeginImageContext(newSize);
    CGContextRef imageContext = UIGraphicsGetCurrentContext();
	
	
	CGContextScaleCTM(imageContext, faktor, faktor);
	
	
    [view.layer renderInContext: imageContext];
    UIImage* viewImage = UIGraphicsGetImageFromCurrentImageContext();
	
    UIGraphicsEndImageContext();
    return viewImage;
	
}


// 图片都是～ipad和@2x～ipad，如果是iphone,没有ddd。png,只有ddd~ipad.png，img是nil,所以自动加上～ipad
+ (UIImage*)imageNamedUniversal:(NSString*)name{ //ddd.png
	
	UIImage *img = [UIImage imageNamed:name];
	
	if (!img) {
		NSString *prefix = [name stringByDeletingPathExtension];
//		NSLog(@"prefix:%@",prefix);
	
		NSString *extention = name.pathExtension;
//		NSLog(@"extention:%@",extention);
		
		NSString *newImgName = [NSString stringWithFormat:@"%@~ipad.%@",prefix,extention];
//		NSLog(@"new ImgName:%@",newImgName);
		img = [UIImage imageNamed:newImgName];
	}
	
	return img;
}


+ (UIImage*)imageWithContentsOfFileUniversal:(NSString *)fileName{
	NSString *prefix = [fileName stringByDeletingPathExtension];
	NSString *extension = fileName.pathExtension;	
	NSString *path = [[NSBundle mainBundle] pathForResource:prefix ofType:extension];

//    NSLog(@"path # %@",path);
	UIImage *img;
	if (!path) {
		prefix = [NSString stringWithFormat:@"%@~ipad",prefix];
		
		path = [[NSBundle mainBundle] pathForResource:prefix ofType:extension];
	}
//    NSLog(@"path # %@",path);
	img = [UIImage imageWithContentsOfFile:path];
//	NSLog(@"img # %@,scale # %f",NSStringFromCGSize(img.size),img.scale);
//	if ( 1) {
//		img = [img imageByScalingAndCroppingForSize:CGSizeMake(300, 200)];
//	}
	return img;
	
}

+ (UIImage*)imageWithContentsOfBundleFile:(NSString*)fileName{
	NSString *bundlePath = [[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"utilLib.bundle"];
	NSString *imgPath = [bundlePath stringByAppendingPathComponent:@"images"];
	return [UIImage imageWithContentsOfFile:[imgPath stringByAppendingPathComponent:fileName]];

}


+ (UIImage*)imageWithContentsOfFileName:(NSString *)fileName{
	
	NSString *prefix = [fileName stringByDeletingPathExtension];
	NSString *extension = fileName.pathExtension;
	NSString *path = [[NSBundle mainBundle]pathForResource:prefix ofType:extension];
	
	UIImage *img = [UIImage imageWithContentsOfFile:path];
	
	
	
	return img;
}

/**
 
 用到了FileUniversal
 和CachesPath！！
 不保存到Document，而是保存到Cache！
 */

+ (UIImage*)imageWithSystemName:(NSString*)fileName{
	UIImage *img;
	
    img = [UIImage imageWithContentsOfFileUniversal:fileName];
	
//	NSLog(@"img is in bundle # %@",fileName);
	
	///如果不是bundle的图片，就从cache中找
	
//	if(!img){
//		
//		NSString *cacheFilePath = [NSString cachesPathForFileName:fileName];
////		NSLog(@"cache filepath # %@",cacheFilePath);
//		
//		NSData *data = [NSData dataWithContentsOfFile:cacheFilePath];
//		
//		// 旧的版本没有的，上线就可以删除了！！
//		if(!data){
////			NSLog(@"caches image nil");
//			data = [NSData dataWithContentsOfFile:[NSString dataFilePath:fileName]];
//		}
//		
//		img = [UIImage imageWithData:data scale:[[UIScreen mainScreen]scale]];
//		
//		if (!img) {
//			NSLog(@"image with system name load error # %@",fileName);
//		}
//	}
//	
	
	return img;
}


//+ (UIImage*)imageWithCacheName:(NSString*)fileName{
//    NSString *cacheFilePath = [NSString cachesPathForFileName:fileName];
//    //		NSLog(@"cache filepath # %@",cacheFilePath);
//    
//    NSData *data = [NSData dataWithContentsOfFile:cacheFilePath];
//    
//    // 旧的版本没有的，上线就可以删除了！！
//    if(!data){
//        //			NSLog(@"caches image nil");
//        data = [NSData dataWithContentsOfFile:[NSString dataFilePath:fileName]];
//    }
//    
//    UIImage *img = [UIImage imageWithData:data scale:[[UIScreen mainScreen]scale]];
//    
//    if (!img) {
//        NSLog(@"image with cache name load error # %@",fileName);
//        img = [UIImage imageWithContentsOfFileUniversal:fileName];
//    }
//    
//    return img;
//
//}
#pragma mark - Save
//
//- (void)saveWithName:(NSString*)fileName{
//	
//    
//    
//	///
//	NSData *data;
//    UIImage *img;
//    if (isPad && isRetina && NO) {
//        img = [self imageByScalingAndCroppingForSize:CGSizeMake(1024/2, 768/2)];
//    }
//    else{
//        img = self;
//    }
//    
//    NSLog(@"img size # %@, scale # %f",NSStringFromCGSize(img.size),img.scale);
//	if ([self hasAlpha]) {
//		data = UIImagePNGRepresentation(img);
//	}
//	else{
//		data = UIImageJPEGRepresentation(img, 0.8);
//	}
//
//    
//	
//	NSString *filePath = [NSString cachesPathForFileName:fileName];
//	BOOL successful = [data writeToFile:filePath atomically:YES];
//	
//	if (!successful) {
//		NSLog(@"Error: save # %@ to %@ ",fileName,filePath);
//	}
//    
//    NSLog(@"save image in path # %@",filePath);
//	
//}
//

#pragma mark - Draw
- (UIImage*)imageByCroppedPath:(UIBezierPath*)path{
    
	/// 处理path的bounds超出self.bounds的情况
    CGRect pathRect = path.bounds;
    CGRect imgRect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGRect newPathRect = CGRectIntersection(pathRect, imgRect);
  
    UIGraphicsBeginImageContext(self.size);

	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextAddPath(context, path.CGPath);
    CGContextClip(context);
    
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];

	UIImage *img= UIGraphicsGetImageFromCurrentImageContext();
	
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    
    CGImageRef drawImage = CGImageCreateWithImageInRect(img.CGImage, newPathRect);
    UIImage *croppedImage = [UIImage imageWithCGImage:drawImage];
	CGImageRelease(drawImage);
	
    return croppedImage;
}

@end
