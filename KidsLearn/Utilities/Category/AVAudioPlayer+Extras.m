//
//  AVAudioPlayer+Extras.m
//  KidsLearn
//
//  Created by  on 29.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "AVAudioPlayer+Extras.h"

@implementation AVAudioPlayer (Extras)


- (void)fadeOut{
	
	if (self.volume > 0.1) {
        self.volume = self.volume - 0.1;
        [self performSelector:@selector(fadeOut) withObject:nil afterDelay:0.1];           
	} else {
		
        [self stop];
        self.currentTime = 0;
        self.volume = 1.0;
		
    }

}

- (void)fadeIn{
	
	self.volume+=0.1;
	
}

- (void)playFading{
	self.volume = 0.0;
	[self play];
	
	if (self.volume<1.0) {
		self.volume+=0.1;
		[self performSelector:@selector(fadeIn) withObject:nil afterDelay:0.1];
	}

}
@end
