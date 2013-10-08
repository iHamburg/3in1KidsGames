//
//  TriangleTestView.m
//  KidsLearn
//
//  Created by  on 25.06.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "TriangleTestView.h"

@implementation TriangleTestView


- (void)load{
	//	L();
	[super load];
	

	building = [Sprite spriteWithName:@"castle.png" origin:CGPointMake(385, 250)];
    building.delegate = self;
	cloud1 = [Sprite spriteWithName:@"triangle_cloud_big.png" origin:CGPointMake(230, 200)];
    cloud1.delegate = self;
	cloud2 = [Sprite spriteWithName:@"triangle_cloud_small.png" origin:CGPointMake(520, 300)];
	cloud2.delegate = self;
	lion = [Sprite spriteWithNames:[NSArray arrayWithObjects:@"triangle_lion0.png",@"triangle_lion1.png", nil]];
	[lion setOrigin:CGPointMake(210, 400)];
	lion.animationRepeatCount = 1;
    lion.delegate = self;
	
	[self addSubview:building];
	[self addSubview:cloud1];
	[self addSubview:cloud2];
	[self addSubview:lion];
	
}



- (void)setup{
	L();
	[super setup];
	
}



#pragma mark -
- (void)startCorrectAnimating{
	
	[super startCorrectAnimating];
	

	[lion startAnimating];

	// cloud away
	[AnimationiManager move:cloud1 away:CGPointMake(-100, 0)];
	[AnimationiManager move:cloud2 away:CGPointMake(100, 0)];
	
}

- (void)startWrongAnimating{
	
	
	[super startWrongAnimating];
	
	
	[AnimationiManager waver:building];
	[AnimationiManager waver:cloud1];
	[AnimationiManager waver:cloud2];
	
}



#pragma mark - Sprite
- (void)spriteDidClicked:(Sprite *)sprite{
    [super spriteDidClicked:sprite];
    
    if(!isEnding){
        return;
    }
    
    [AudioController playItemButton];
    
    if (sprite == building) {
        [AudioController playShape:selectedIndex delegate:nil];
    }
    else if(sprite == lion){
        [lion startAnimating];
    }
    else if (sprite == cloud1){ // cloud
        int x = arc4random()%11;
        int y = arc4random()%11;
        
        [AnimationiManager move:cloud1 away:CGPointMake(x-5, y-5)];
        
       
    }
    else {
        int x = arc4random()%11;
        int y = arc4random()%11;
        
        [AnimationiManager move:cloud2 away:CGPointMake(x-5, y-5)];
        

    }
    
}

@end
