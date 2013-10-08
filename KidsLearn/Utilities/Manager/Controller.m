//
//  Controller.m
//  SportTraining
//
//  Created by  on 10.03.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Controller.h"


@implementation Controller

@synthesize mode;

+(id)sharedInstance{
	static id sharedInstance;
	if (sharedInstance == nil) {
		
		sharedInstance = [[[self class] alloc]init];
	}
	
	return sharedInstance;
	
}

- (id)init{
	if (self = [super init]) {

		[AudioController sharedInstance];
		[SpriteManager sharedInstance];
		[ExportController sharedInstance];
		
		colors = [NSArray arrayWithObjects:[UIColor colorWithHEX:@"cf171f"], // red
				  [UIColor colorWithHEX:@"f57921"],
				  [UIColor colorWithHEX:@"ffde00"],
				  [UIColor colorWithHEX:@"018345"],
				  [UIColor colorWithHEX:@"ff7e94"], 
				  [UIColor colorWithHEX:@"2e3094"], 
				  [UIColor colorWithHEX:@"c756a1"],nil];
        
        
        foodNames = [NSArray arrayWithObjects:@"food_banana.png",@"food_egg.png",@"food_eggplant.png",@"food_greenapple.png",@"food_hamburger.png",
                     @"food_lemon.png",@"food_stawberry.png",nil];
	}
	return self;
}



#pragma mark -



- (UIColor*)colorWithIndex:(int)index{
	
	return [colors objectAtIndex:index];
}

- (UIImage*)foodImageForNumberTest{
    int index = arc4random()%[foodNames count];
    return [UIImage imageNamed:[foodNames objectAtIndex:index]];
}
#pragma mark - ColorFilter
- (UIImage *)makeImageBW:(UIImage*)img
{
    CIImage *beginImage = [CIImage imageWithCGImage:img.CGImage];
	
    CIImage *blackAndWhite = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputImageKey, beginImage, @"inputBrightness", [NSNumber numberWithFloat:0.0], @"inputContrast", [NSNumber numberWithFloat:1.1], @"inputSaturation", [NSNumber numberWithFloat:0.0], nil].outputImage;
    CIImage *output = [CIFilter filterWithName:@"CIExposureAdjust" keysAndValues:kCIInputImageKey, blackAndWhite, @"inputEV", [NSNumber numberWithFloat:0.7], nil].outputImage; 
	
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef cgiimage = [context createCGImage:output fromRect:output.extent];
    
    CGFloat scale = isRetina?2.0:1.0;
    UIImage *newImage = [UIImage imageWithCGImage:cgiimage scale:scale orientation:UIImageOrientationUp];
	
    CGImageRelease(cgiimage);
	
    
    return newImage;
}



@end
