//
//  AudioController.m
//  FirstThings_Uni
//
//  Created by  on 11.02.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "AudioController.h"

@implementation AudioController

static NSMutableArray *numberPlayers;
static NSMutableArray *shapePlayers;
static NSMutableArray *colorPlayers;
static NSArray *audioPlayers;
static AVAudioPlayer *bgMusicPlayer;
static AVAudioPlayer *waterPlayer;
static SystemSoundID yesids[4];
static SystemSoundID noids[4];
static SystemSoundID noButtonid;
static SystemSoundID giraffelMoveid, didaid,itemButtonid;


@synthesize silent;

- (id)init{
	if (self = [super init]) {


		
		AVAudioPlayer *cheerplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL urlWithResourceName:@"Cheers_kids" type:@"mp3"] error:nil];
		AVAudioPlayer *wrongPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL urlWithResourceName:@"wrong" type:@"mp3"] error:nil];
		audioPlayers = [NSArray arrayWithObjects:cheerplayer,wrongPlayer, nil];
		
		
		numberPlayers = [NSMutableArray array];
		for (int i = 1; i<11; i++) {
			AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL urlWithResourceName:[NSString stringWithInt:i] type:@"mp3"] error:nil];
			[numberPlayers addObject:player];
		}
		
		colorPlayers = [NSMutableArray array];
		for (int i = 0; i<7; i++) {
			AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL urlWithResourceName:[NSString stringWithFormat:@"c%d",i] type:@"mp3"] error:nil];
			[colorPlayers addObject:player];
		}
		
		shapePlayers = [NSMutableArray array];
		for (int i = 0; i<6; i++) {
			AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL urlWithResourceName:[NSString stringWithFormat:@"s%d",i+1] type:@"mp3"] error:nil];
			[shapePlayers addObject:player];
		}
		
	

		NSArray *audioNames = [NSArray arrayWithObjects:@"Cheers_kids.mp3",@"wrong.mp3",@"Button_Click.mp3", nil];
		
		for(int i=0;i<[audioNames count];i++){
			SystemSoundID soundid = 0;
			AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL urlWithFilename:[audioNames objectAtIndex:i]], &soundid); 
			audios[i] = soundid;
		}
	

		NSString *yesNames[]={
			@"Kids_yeah_mixdown.mp3",@"that is so cool.mp3"
		};
		for(int i=0;i<2;i++){
			SystemSoundID soundid = 0;
			AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL urlWithFilename:yesNames[i]], &soundid); 
			yesids[i] = soundid;
		}
		
		NSString *noNames[]={
			@"Kids_NO.mp3",@"Wrong_answer.mp3"
		};
		for(int i=0;i<2;i++){
			SystemSoundID soundid = 0;
			AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL urlWithFilename:noNames[i]], &soundid); 
			noids[i] = soundid;
		}
		
		noButtonid = 0;
		AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL urlWithFilename:@"Wrong_answer.mp3"], &noButtonid); 
		
        eatid = 0;
        AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL urlWithFilename:@"eating.mp3"], &eatid);
		
        giraffelMoveid = 0;
        AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL urlWithFilename:@"giraffes_animation2.mp3"], &giraffelMoveid);

        didaid = 0;
        AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL urlWithFilename:@"3dida.mp3"], &didaid);
        
        itemButtonid = 0;
        AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL urlWithFilename:@"Button_Click.mp3"], &itemButtonid);
        
		bgMusicPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL urlWithFilename:@"background_music.mp3"] error:nil];
		bgMusicPlayer.numberOfLoops = -1;
        
        waterPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL urlWithFilename:@"stream-3.mp3"] error:nil];
        waterPlayer.numberOfLoops = -1;
		
		silent = [[NSUserDefaults standardUserDefaults]boolForKey:@"silent"];
		NSLog(@"AudioController.silent:%d",silent);
		
	}
	return self;
}

+(id)sharedInstance{
	static id sharedInstance;
	if (sharedInstance == nil) {
		
		sharedInstance = [[[self class] alloc]init];
	}
	
	return sharedInstance;
	
}


- (void)playSound:(AudioType)type{
	
	if (type == AudioEating) {
		 AudioServicesPlaySystemSound(eatid);
		return;
	}
	
	SystemSoundID soundid = audios[type];
	AudioServicesPlaySystemSound(soundid);
	
}



+ (void)playAudio:(AudioType)type delegate:(id)delegate{
//	NSLog(@"play:%d",type);
	
	AVAudioPlayer *player = [audioPlayers objectAtIndex:type];
	
	player.delegate = delegate;
	

	[player play];
	
	
}

+ (void)playNumber:(int)numberIndex delegate:(id)delegate{
	AVAudioPlayer *player = [numberPlayers objectAtIndex:numberIndex];
	player.delegate = delegate;
	[player play];
}

+ (void)playShape:(Shape)shape delegate:(id)delegate{
	AVAudioPlayer *player = [shapePlayers objectAtIndex:shape];
	player.delegate = delegate;
	[player play];
}


+ (void)playColor:(Color)color delegate:(id)delegate{
	AVAudioPlayer *player = [colorPlayers objectAtIndex:color];
	player.delegate = delegate;
	[player play];
}




- (void)playBGMusic{
	
	if (silent) {
		return;
	}
	
	[bgMusicPlayer playFading];
}
- (void)stopBGMusic{

	[bgMusicPlayer fadeOut];

}

- (void)playWaterMusic{
	
	if (silent) {
		return;
	}
	
	[waterPlayer playFading];
	
}
- (void)stopWaterMusic{
  
	[waterPlayer fadeOut];
}

+ (void)playCheer{
	int i = arc4random()%2;
	
	SystemSoundID soundid = yesids[i];
	AudioServicesPlaySystemSound(soundid);
}
+ (void)playWrong{
	int i = arc4random()%2;
	SystemSoundID soundid = noids[i];
	AudioServicesPlaySystemSound(soundid);
	
}

+ (void)playWrongButton{
	
	AudioServicesPlaySystemSound(noButtonid);
}

+ (void)playEating{
    
//    AudioServicesPlaySystemSound(eatid);
}

+ (void)playGiraffMove{
    AudioServicesPlaySystemSound(giraffelMoveid);
}

+ (void)playSSDida{
    AudioServicesPlaySystemSound(didaid);
}

+ (void)playItemButton{
    AudioServicesPlaySystemSound(itemButtonid);
}

+(void)doVolumeFade:(AVAudioPlayer*)player
{  
	

    if (player.volume > 0.1) {
        player.volume = player.volume - 0.1;
        [self performSelector:@selector(doVolumeFade:) withObject:player afterDelay:0.1];           
	} else {

        [player stop];
        player.currentTime = 0;
        player.volume = 1.0;
    }
}
@end
