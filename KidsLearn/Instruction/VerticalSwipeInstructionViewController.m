//
//  VerticalSwipeInstructionViewController.m
//  iCamAlbum
//
//  Created by AppDevelopper on 13-9-13.
//  Copyright (c) 2013年 Xappsoft. All rights reserved.
//

#import "VerticalSwipeInstructionViewController.h"

@implementation VerticalSwipeInstructionViewController

#define kNumOfPage 7

- (void)loadView{
    
    self.view = [[UIView alloc] initWithFrame:_r];
    
    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    gesture.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:gesture];
    
    
    UISwipeGestureRecognizer *gesture2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    gesture2.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:gesture2];
    
    
//    bgImgNames = [self loadBGImageNames];
    
    bgV1 = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgV2 = [[UIImageView alloc] initWithFrame:self.view.bounds];
    //    bgV.image = [UI];
//    currentImgName = [bgImgNames randomObject];
//    bgV1.image = [UIImage imageWithSystemName:currentImgName];
//
    
    currentIndex = 0;
    imgNames = [NSMutableArray array];
    for (int  i = 1; i<8; i++) {
        [imgNames addObject:[NSString stringWithFormat:@"instruction-story%d.jpg",i]];
    }
    
    bgV1.image = [UIImage imageNamed:imgNames[currentIndex]];
    
    [self.view addSubview:bgV1];
}


- (IBAction)handleSwipe:(UISwipeGestureRecognizer*)sender{
    if (sender.direction == UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"next");
        [self toNextPage];
    }
    else{
        NSLog(@"previous");
        [self toPreviousPage];
    }
}

- (void)toNextPage{
    if (currentIndex < kNumOfPage - 1) {
        [self toPage:currentIndex+1];
    }
    else{
        [_delegate instructionVCWillDismiss:self];
    }
}

- (void)toPreviousPage{
    if (currentIndex>0) {
        [self toPage:currentIndex-1];
    }
}

- (void)toPage:(int)newIndex{
    
    NSLog(@"current # %d, new # %d",currentIndex,newIndex);
    
    UIImageView *currentV;
    UIImageView *nextV;
    
    if (bgV1.superview) {
        currentV = bgV1;
        nextV = bgV2;
    }
    else{
        currentV = bgV2;
        nextV = bgV1;
    }

    nextV.image = [UIImage imageNamed:imgNames[newIndex]];
    

    [self.view addSubview:nextV];
    [currentV removeFromSuperview];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"reveal";
    transition.subtype = currentIndex<newIndex?kCATransitionFromTop:kCATransitionFromBottom;
    [self.view.layer addAnimation:transition forKey:nil];
    
    currentIndex = newIndex;
}
@end
