//
//  Sprite.h
//  KidsLearn
//
//  Created by  on 21.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Utilities.h"

@protocol SpriteDelegate;

@interface Sprite : UIImageView{


}

@property (nonatomic, unsafe_unretained) id<SpriteDelegate> delegate;

- (void)load;

+ (id)spriteWithName:(NSString*)imgName;
+ (id)spriteWithName:(NSString *)imgName origin:(CGPoint)origin;
+ (id)spriteWithNames:(NSArray*)names;
+ (id)spriteWithOrigin:(CGPoint)origin;


- (void)play;
- (void)pause;
- (void)stop;


@end

@protocol SpriteDelegate <NSObject>

@optional
- (void)spriteDidClicked:(Sprite*)sprite;

@end