//
//  LoadingView.m
//  TheBootic
//
//  Created by AppDevelopper on 01.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoadingView.h"

#import <QuartzCore/QuartzCore.h>

//
// NewPathWithRoundRect
//
// Creates a CGPathRect with a round rect of the given radius.
//
CGPathRef NewPathWithRoundRect(CGRect rect, CGFloat cornerRadius)
{
	//
	// Create the boundary path
	//
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL,
                      rect.origin.x,
                      rect.origin.y + rect.size.height - cornerRadius);
    
	// Top left corner
	CGPathAddArcToPoint(path, NULL,
                        rect.origin.x,
                        rect.origin.y,
                        rect.origin.x + rect.size.width,
                        rect.origin.y,
                        cornerRadius);
    
	// Top right corner
	CGPathAddArcToPoint(path, NULL,
                        rect.origin.x + rect.size.width,
                        rect.origin.y,
                        rect.origin.x + rect.size.width,
                        rect.origin.y + rect.size.height,
                        cornerRadius);
    
	// Bottom right corner
	CGPathAddArcToPoint(path, NULL,
                        rect.origin.x + rect.size.width,
                        rect.origin.y + rect.size.height,
                        rect.origin.x,
                        rect.origin.y + rect.size.height,
                        cornerRadius);
    
	// Bottom left corner
	CGPathAddArcToPoint(path, NULL,
                        rect.origin.x,
                        rect.origin.y + rect.size.height,
                        rect.origin.x,
                        rect.origin.y,
                        cornerRadius);
    
	// Close the path at the rounded rect
	CGPathCloseSubpath(path);
	
	return path;
}


@implementation LoadingView

static LoadingView *sharedLoadingView;
static UILabel *loadingLabel;
static UIActivityIndicatorView *activityIndicatorView;

+ (LoadingView*)sharedLoadingView{
	
	
    @synchronized(sharedLoadingView){
        if (sharedLoadingView == nil) {
			//            sharedLoadingView = [[LoadingView alloc ]initWithFrame:CGRectMake(0, 0, 0, 0)];
			//			不能是zero！
			sharedLoadingView = [[LoadingView alloc ]initWithFrame:CGRectMake(0, 0, 1024, 768)];
			sharedLoadingView.opaque = NO;
			sharedLoadingView.autoresizingMask =
			UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
			
			
			const CGFloat DEFAULT_LABEL_WIDTH = 280.0;
			const CGFloat DEFAULT_LABEL_HEIGHT = 50.0;
			CGRect labelFrame = CGRectMake(0, 0, DEFAULT_LABEL_WIDTH, DEFAULT_LABEL_HEIGHT);
			
			loadingLabel =
			[[UILabel alloc]
			 initWithFrame:labelFrame];
			loadingLabel.text = NSLocalizedString(@"Loading...", nil);
			loadingLabel.textColor = [UIColor whiteColor];
			loadingLabel.backgroundColor = [UIColor clearColor];
			loadingLabel.textAlignment = UITextAlignmentCenter;
			loadingLabel.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
			loadingLabel.autoresizingMask =
			UIViewAutoresizingFlexibleLeftMargin |
			UIViewAutoresizingFlexibleRightMargin |
			UIViewAutoresizingFlexibleTopMargin |
			UIViewAutoresizingFlexibleBottomMargin;
			[sharedLoadingView addSubview:loadingLabel];
			
			activityIndicatorView =
			[[UIActivityIndicatorView alloc]
			 initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
			[sharedLoadingView addSubview:activityIndicatorView];
			activityIndicatorView.autoresizingMask =
			UIViewAutoresizingFlexibleLeftMargin |
			UIViewAutoresizingFlexibleRightMargin |
			UIViewAutoresizingFlexibleTopMargin |
			UIViewAutoresizingFlexibleBottomMargin;
			[activityIndicatorView startAnimating];
			
			CGFloat totalHeight =
			loadingLabel.frame.size.height +
			activityIndicatorView.frame.size.height;
			labelFrame.origin.x = floor(0.5 * (sharedLoadingView.frame.size.width - DEFAULT_LABEL_WIDTH));
			labelFrame.origin.y = floor(0.5 * (sharedLoadingView.frame.size.height - totalHeight));
			loadingLabel.frame = labelFrame;
			
			
			CGRect activityIndicatorRect = activityIndicatorView.frame;
			activityIndicatorRect.origin.x =
			0.5 * (sharedLoadingView.frame.size.width - activityIndicatorRect.size.width);
			activityIndicatorRect.origin.y = 0.5*(sharedLoadingView.frame.size.height-activityIndicatorRect.size.height);
			activityIndicatorView.frame = activityIndicatorRect;
			//			NSLog(@"self:%@,activity:%@,label:%@",sharedLoadingView,activityIndicatorView,loadingLabel);
			
			
        }
    }
    
    return sharedLoadingView;
}


- (void)removeView{
	
	UIView *aSuperview = [sharedLoadingView superview];
	
    [sharedLoadingView removeFromSuperview];  
	
	CATransition *animation = [CATransition animation];
	[animation setType:kCATransitionFade];
	[animation setDuration:.5];
	[[aSuperview layer] addAnimation:animation forKey:@"layerAnimation"];
}


- (void)addInView:(UIView*)aSuperview{
	
	loadingLabel.text = @"";
	[activityIndicatorView startAnimating];
	
    self.frame = aSuperview.bounds;
    [aSuperview addSubview:self];
    
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionFade];
	
    [[aSuperview layer] addAnimation:animation forKey:@"layerAnimation"];
	
	//	[self performSelector:@selector(removeView) withObject:nil afterDelay:2];
	
	
}

- (void)showTitle:(NSString*)title inView:(UIView*)aSuperview{
	loadingLabel.text = title;
	[activityIndicatorView stopAnimating];
	
	self.frame = aSuperview.bounds;
	[aSuperview addSubview:self];
	
	[self performSelector:@selector(removeView) withObject:nil afterDelay:1];
	
}

- (void)drawRect:(CGRect)rect
{
	
	rect.size.height -= 1;
	rect.size.width -= 1;
	
	const CGFloat RECT_PADDING = 8.0;
	rect = CGRectInset(rect, RECT_PADDING, RECT_PADDING);
	
	const CGFloat ROUND_RECT_CORNER_RADIUS = 5.0;
    float rectWidth = isPad?240:180;
    float rectHeight = isPad?160:120;
    
	//  CGRect blackRect = CGRectMake(0.3*rect.size.width, 0.3*rect.size.height, 0.4*rect.size.width, 0.4*rect.size.height);
	CGRect blackRect = CGRectMake(0.5*(rect.size.width-rectWidth)+rect.origin.x, 0.5*(rect.size.height-rectHeight)+rect.origin.y, rectWidth, rectHeight);
	
	// DLog(@"rect:%@,blackRect:%@",NSStringFromCGRect(rect),NSStringFromCGRect(blackRect));
	
	CGPathRef roundRectPath = NewPathWithRoundRect(blackRect, ROUND_RECT_CORNER_RADIUS);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	const CGFloat BACKGROUND_OPACITY = 0.85;
	CGContextSetRGBFillColor(context, 0, 0, 0, BACKGROUND_OPACITY);
	CGContextAddPath(context, roundRectPath);
	CGContextFillPath(context);
	
	const CGFloat STROKE_OPACITY = 0.25;
	CGContextSetRGBStrokeColor(context, 1, 1, 1, STROKE_OPACITY);
	CGContextAddPath(context, roundRectPath);
	CGContextStrokePath(context);
	
	CGPathRelease(roundRectPath);
    
	
	
}

#pragma mark -




@end
