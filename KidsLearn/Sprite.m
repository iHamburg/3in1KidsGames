//
//  Sprite.m
//  KidsLearn
//
//  Created by  on 21.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "Sprite.h"

@implementation Sprite

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		[self load];
    }
    return self;
}


- (id)initWithImage:(UIImage*)image{

	if (self = [super initWithImage:image]) {
		[self load];
	}
	return self;
}


- (void)load{
	
	self.animationDuration = 1;
	self.animationRepeatCount = 0;
	self.userInteractionEnabled = YES;
	
	[self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
}

+ (id)spriteWithName:(NSString*)imgName{
	UIImage *img = [UIImage imageNamed:imgName];
	return [[Sprite alloc]initWithImage:img];
}

+ (id)spriteWithName:(NSString *)imgName origin:(CGPoint)origin{
	Sprite *sprite = [Sprite spriteWithName:imgName];
	[sprite setOrigin:origin];
	return sprite;
}

+ (id)spriteWithNames:(NSArray*)names{
	NSMutableArray *imgs = [NSMutableArray array];
	for (NSString *name in names) {
		UIImage *img = [UIImage imageNamed:name];
		[imgs addObject:img];
	}
	Sprite *sprite = [[Sprite alloc]initWithImage:[imgs objectAtIndex:0]];
	sprite.animationImages = imgs;
	return sprite;
}

+ (id)spriteWithOrigin:(CGPoint)origin{
	Sprite *sprite = [[Sprite alloc]initWithFrame:CGRectMake(origin.x, origin.y, 0, 0)];
	return sprite;
}
#pragma mark - Property
- (void)setImage:(UIImage *)image{
//	L();
	[super setImage:image];
	[self setSize:image.size];
}

#pragma mark - IBOutlet
- (void)handleTap:(UITapGestureRecognizer*)gesture{
//	L();
	if ([delegate respondsToSelector:@selector(spriteDidClicked:)]) {
		[delegate spriteDidClicked:self];
	}
}

#pragma mark - Control
- (void)play{
	L();
//	[imgV startAnimating];
}
- (void)pause{

}
- (void)stop{
//	[imgV stopAnimating];
}
@end
