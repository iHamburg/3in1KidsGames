//
//  UIWebView+Extras.m
//  TheBootic
//
//  Created by  on 22.12.11.
//  Copyright (c) 2011 Xappsoft. All rights reserved.
//

#import "UIWebView+Extras.h"

@implementation UIWebView (Extras)

- (void)loadHTMLStringFromFileName:(NSString*)fileName baseURL:(NSURL*)baseURL{
	NSString* filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
	NSError *error = nil;
	NSString* text = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    [self loadHTMLString:text baseURL:baseURL];
	
}

@end
