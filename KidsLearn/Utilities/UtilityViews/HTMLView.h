//
//  HTMLView.h
//  Webmoebel
//
//  Created by Michael Zapf on 30.05.11.
//  Copyright 2011 mimagazine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>
#import "CascadeScrollView.h"
#import "Category.h"

@interface HTMLView : UIView {

}
@property (nonatomic) BOOL gradient;
@property (nonatomic, strong) NSURL* baseURL;
@property (nonatomic, strong) NSString* htmlString;
@property (nonatomic, copy) NSArray *passthroughViews;
@property (nonatomic, strong,readonly) CascadeScrollView* scrollView;
@property (nonatomic, strong,readonly) UIWebView* webView;

- (void)setBody:(NSString*)body withCSSFileName:(NSString*)cssFileName;

- (void)setScrollViewEnable:(BOOL)flag;
- (void)setScrollOffset:(CGPoint)point;
- (void)setScrollViewDelegate:(id)delegate;



@end
