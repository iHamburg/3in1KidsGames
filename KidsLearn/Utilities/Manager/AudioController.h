//
//  AudioController.h
//  FirstThings_Uni
//
//  Created by  on 11.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import  <AVFoundation/AVFoundation.h>
#import <AudioToolbox/Audiotoolbox.h>
#import "Utilities.h"

typedef enum{
	AudioCheer,
	AudioWrong,
	AudioButton,
	AudioEating
}AudioType;

@interface AudioController : NSObject{
	
	SystemSoundID audios[10]; // for AudioType
	
	SystemSoundID eatid;
	
}

@property(nonatomic, assign) BOOL silent;

+(id)sharedInstance;

+(void)doVolumeFade:(AVAudioPlayer*)player;

- (void)playSound:(AudioType)type;


+ (void)playAudio:(AudioType)type delegate:(id)delegate;
+ (void)playShape:(Shape)shape delegate:(id)delegate;
+ (void)playNumber:(int)numberIndex delegate:(id)delegate;
+ (void)playColor:(Color)color delegate:(id)delegate;


- (void)playWaterMusic;
- (void)stopWaterMusic;

- (void)playBGMusic;
- (void)stopBGMusic;

+ (void)playCheer;
+ (void)playWrong;
+ (void)playWrongButton;
+ (void)playGiraffMove;
+ (void)playSSDida;
+ (void)playItemButton;

@end
