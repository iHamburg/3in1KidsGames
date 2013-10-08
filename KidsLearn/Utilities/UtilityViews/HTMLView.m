//
//  HTMLView.m
//  Webmoebel
//
//  Created by Michael Zapf on 30.05.11.
//  Copyright 2011 mimagazine. All rights reserved.
//

#import "HTMLView.h"



@interface HTMLView () <UIWebViewDelegate>




- (void)initialize;

@end


@implementation HTMLView
@synthesize webView;
@synthesize scrollView;
@synthesize baseURL;
@synthesize htmlString,gradient;

- (CascadeScrollView*)scrollView {
	if (scrollView == nil) {
		scrollView = [[CascadeScrollView alloc] initWithFrame:self.bounds];
		scrollView.backgroundColor = [UIColor clearColor];
		scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		scrollView.opaque = NO;
		scrollView.showsVerticalScrollIndicator = NO;
		scrollView.showsHorizontalScrollIndicator = NO;
		[self addSubview:scrollView];
	}
	return scrollView;
}

- (void)setPassthroughViews:(NSArray *)value {
	scrollView.passthroughViews = value;
}

- (NSArray*)passthroughViews {
	return scrollView.passthroughViews;
}

- (UIWebView*)webView {
	if (webView == nil) {
		webView = [[UIWebView alloc] initWithFrame:self.scrollView.bounds];
		webView.backgroundColor = [UIColor clearColor];
		webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		webView.opaque = NO;
		webView.delegate = self;
		webView.dataDetectorTypes = UIDataDetectorTypeNone;
		webView.alpha = 0.0f;	//to fade in
		webView.userInteractionEnabled = NO;

		[self.scrollView addSubview:webView];
	}
	return webView;
}

- (NSURL*)baseURL {
	if (baseURL == nil) {
		baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]];
	}
   // DLog(@"baseURL:%@",[[NSBundle mainBundle] resourcePath]);
	return baseURL;
}

- (void)setHtmlString:(NSString *)value {
	if (htmlString != value) {

		htmlString = value;
	}
	
	[self.webView loadHTMLString:htmlString baseURL:self.baseURL];
}

- (void)setBody:(NSString*)body withCSSFileName:(NSString*)cssFileName {
	self.htmlString = [NSString stringWithFormat:@"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\"><html><head><link rel=\"stylesheet\" href=\"%@\" type=\"text/css\"/></head> <body>%@</body> </html>", cssFileName, body];
}

- (void)setScrollViewEnable:(BOOL)flag{
    //LocLog();
    [self.scrollView setScrollEnabled:flag];
}

- (void)setScrollOffset:(CGPoint)point{
    [self.scrollView setContentOffset:point];
}
- (void)setScrollViewDelegate:(id)delegate{
    self.scrollView.delegate = delegate;
}

- (id)initWithCoder:(NSCoder*)coder {
	if ((self = [super initWithCoder:coder])) {
		[self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		[self initialize];
    }
    return self;
}

- (void)initialize {
	self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.gradient = YES;
}



#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView_ {
}

- (void)webViewDidFinishLoad:(UIWebView *)webView_ {
//	DebugLog(@"%s", __FUNCTION__);
	
	self.webView.backgroundColor = [UIColor clearColor];
	CGSize size = CGSizeMake(self.frame.size.width, 10000.0f);
	size = [self.webView sizeThatFits:size];
	CGRect frame = self.webView.frame;
	frame.size = size;
	self.webView.frame = frame;
	self.scrollView.contentSize = frame.size;
    if (gradient) {
        	[self applyGradientBorder:kCALayerBottomEdge | kCALayerTopEdge indent:10.0f];
    }

//	[UIView fadeIn:[NSArray arrayWithObject:self.webView]];
  

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//	DebugLog(@"%s %@", __FUNCTION__, [error localizedDescription]);
}



- (void)dealloc {

}


@end
