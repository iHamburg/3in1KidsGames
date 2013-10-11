//
//  MoreApp.m
//  InstaMagazine
//
//  Created by AppDevelopper on 14.10.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "MoreApp.h"

@implementation MoreApp

@synthesize name,title,description,pAppid,fAppid,imgName;


- (id)initWithName:(NSString*)_name dictionary:(NSDictionary*)dict{
	if (self = [super init]) {
		name = _name;
		title = dict[@"Title"];
		imgName = dict[@"Image"];
		description = dict[@"Description"];
		pAppid = dict[@"PAppid"];
		fAppid = dict[@"FAppid"];
	}
	return self;
}
@end
