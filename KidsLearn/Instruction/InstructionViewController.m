//
//  InstructionViewController.m
//  MyPhotoAlbum
//
//  Created by AppDevelopper on 16.09.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "InstructionViewController.h"
#import "Utilities.h"
//#import <QuartzCore/QuartzCore.h>

@interface InstructionViewController ()

@end

@implementation InstructionViewController

- (void)loadView{
	self.view = [[UIView alloc]initWithFrame:_r];
	UIImageView *bgV = [[UIImageView alloc]initWithFrame:self.view.bounds];

		
	CGFloat yPageControl = isPad?712:300;
	pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, yPageControl, _w, _h-yPageControl)];
	pageControl.numberOfPages = numOfPages;
	pageControl.userInteractionEnabled = NO;
	
	[self.view addSubview:bgV];
	[self.view addSubview:scrollView];
	[self.view addSubview:pageControl];
	[self.view addSubview:backB];
	
}

- (void)viewDidAppear:(BOOL)animated{
	L();
	[super viewDidAppear:animated];
	self.view.frame =_r;
}

- (void)dealloc{
    L();
}

#pragma mark - IBAction
- (void)buttonClicked:(id)sender{
	if (sender == backB) {

		[_delegate instructionVCWillDismiss:self];
	}
}

#pragma mark - ScrollView & PageControl

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView{
	CGFloat xOffset = scrollView.contentOffset.x;
	int page = xOffset/scrollView.width;
	pageControl.currentPage = page;
}

@end
