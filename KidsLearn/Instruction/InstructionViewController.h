//
//  InstructionViewController.h
//  MyPhotoAlbum
//
//  Created by AppDevelopper on 16.09.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Utilities.h"

@protocol InstructionDelegate;
@interface InstructionViewController : UIViewController<UIScrollViewDelegate>{
	UIButton *backB;
	UIPageControl *pageControl;
    UIScrollView *scrollView;
    
    NSMutableArray *imgNames;
    int numOfPages;
    
    __unsafe_unretained id<InstructionDelegate> _delegate;
}

@property (nonatomic, unsafe_unretained) id<InstructionDelegate> delegate;



@end

@protocol InstructionDelegate <NSObject>

- (void)instructionVCWillDismiss:(InstructionViewController*)vc;

@end