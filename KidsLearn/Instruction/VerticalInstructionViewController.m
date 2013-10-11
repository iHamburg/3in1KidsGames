//
//  VerticalInstructionViewController.m
//  Everalbum
//
//  Created by AppDevelopper on 13-9-3.
//  Copyright (c) 2013年 Xappsoft. All rights reserved.
//

#import "VerticalInstructionViewController.h"

@interface VerticalInstructionViewController ()

@end

@implementation VerticalInstructionViewController


- (void)loadView{
    self.view = [[UIView alloc]initWithFrame:_r];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
	scrollView.backgroundColor = [UIColor clearColor];
	scrollView.pagingEnabled = YES;
	scrollView.delegate = self;

	
        
	
  
    [self.view addSubview:scrollView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    NSLog(@"delegate # %@",_delegate);

}


#pragma mark - ScrollView
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView{
    CGFloat yOffset = scrollView.contentOffset.y;
    
//    NSLog(@"yOffset # %f",yOffset);
    CGFloat yValue = (numOfPages - 1)*_h;
    
    
    /// 会多次被调用！不是想要的。但是效果确是预计要达到的！
    if (yOffset>yValue ) {
        
        [scrollView setContentOffset:CGPointMake(0, (numOfPages-1)*_h) animated:NO];
        
        [_delegate instructionVCWillDismiss:self];

    }
}

@end
