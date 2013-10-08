//
//  XCChooseViewController.m
//  KidsLearn
//
//  Created by XC on 6/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XCChooseViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "XCNumberView.h"
//#import "XCColorView.h"
#import "XCShapeView.h"
#import "XCResultView.h"


@implementation XCChooseViewController

@synthesize containerNumbers,containerShapes,containerColors,home;

@synthesize sheep;

@synthesize toNumberModus, toColorModus, toShapeModus;
@synthesize selectedNumberIndex,mode;
@synthesize rootVC;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

	resultV = [[XCResultView alloc] initWithFrame:self.view.bounds];
	
    scollContrainer = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 323, 1024, 445)];
    scollContrainer.backgroundColor = [UIColor clearColor];
    containerNumbers.frame = CGRectMake(0, 0, 1024, 445);
    [scollContrainer addSubview:containerNumbers];
  
    [self.view addSubview:scollContrainer];
    
    page = SpielPageNumber;
	
	mode = spielModeTest;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"choose view will appear");
    
    [super viewWillAppear:YES];
 
        
	testNumberindex = arc4random()%10;  //0 -9
	
	testColorIndex = arc4random()%7;    //0 - 6
	
	testShapeIndex = arc4random()%6;     //0- 5
		NSLog(@"indexNum:%d,indexColor:%d,indexShape:%d",testNumberindex,testColorIndex,testShapeIndex);

	
	[self setup];

//    [self performSelector:@selector(willToNumber) withObject:nil afterDelay:0.5];

	
    
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
        
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


- (void)setup{

	
	//set number to first
	[self toNumber];
	
}

#pragma mark - IBAction
- (IBAction)buttonClicked:(id)sender{
    
	if (sender == againB) {
		// choose again
		NSLog(@"choose again");
		testNumberindex = arc4random()%10;  //0 -9
		
		testColorIndex = arc4random()%7;    //0 - 6
		
		testShapeIndex = arc4random()%6;     //0- 5
		
		[self setup];
		

	}
    else if(sender == home){
        [containerColors removeFromSuperview];
        [containerShapes removeFromSuperview];
        [resultV removeFromSuperview];
        againB.hidden = YES;
    
        [self.view removeFromSuperview];
        [rootVC viewDidAppear:YES];
    }
	
}

#pragma mark - Navigation


- (void)toNumber{
   
	[containerColors removeFromSuperview];
    [containerShapes removeFromSuperview];
   
    [resultV removeFromSuperview];
	againB.hidden = YES;
	
    containerNumbers.frame = CGRectMake(0, 323, 1024, 445);
    
    [self performSelector:@selector(willToNumber) withObject:nil afterDelay:0.5];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType:kCATransitionFromTop];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [self.view addSubview:containerNumbers] ;
    
    [[self.view layer] addAnimation:animation forKey:@"SwitchToView1"];

 
    page = SpielPageNumber;
    

}
- (void)toColor{

    
    [containerNumbers removeFromSuperview];
    

    containerColors.frame = CGRectMake(0, 0, 1024, 445);
   
	CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
	[scollContrainer addSubview:containerColors];
	
    [[scollContrainer layer] addAnimation:animation forKey:@"SwitchToView1"];
   
        

	[self performSelector:@selector(willToColor) withObject:nil afterDelay:0.5];
	
    // set up an animation for the transition between the views

    
    page = SpielPageColor;
}




- (void)toShape{
    

    [containerColors removeFromSuperview];


 
    containerShapes = [[XCShapeView alloc] initWithFrame:CGRectMake(100, 0, 800, 400)];
	containerShapes.delegate = self;
	containerShapes.drawOrigin = CGPointMake(0, 20);
	containerShapes.strokeColor = [[Controller sharedInstance]colorWithIndex:testColorIndex];
	
    [scollContrainer addSubview:containerShapes];

//    [self willToShape];
//    
    [self performSelector:@selector(willToShape) withObject:nil afterDelay:0.5];
    
    // set up an animation for the transition between the views
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[scollContrainer layer] addAnimation:animation forKey:@"SwitchToView1"];
    
    page = SpielPageShape;
}

- (void)toResult{


	[AudioController playAudio:AudioCheer delegate:nil];

    
    [containerShapes removeFromSuperview];
    
   
    resultV.shape = selectedShapeIndex;
    resultV.color = selectedColorIndex;
    resultV.numberIndex = selectedNumberIndex;

	againB.hidden = NO;
	[resultV setup];
	
    // set up an animation for the transition between the views
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType:kCATransitionFromBottom];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    

	[self.view insertSubview:resultV belowSubview:home];


    [[self.view layer] addAnimation:animation forKey:@"SwitchToView1"];
    
    page = SPielPageResult;

}

- (void)willToNumber{
	
	[AudioController playNumber:testNumberindex delegate:nil];

	[AnimationiManager scale:sheep withScale:1.5 times:1];
}
- (void)willToColor{
	
	[AudioController playColor:testColorIndex delegate:nil];

	[AnimationiManager scale:sheep withScale:1.5 times:1];

}
- (void)willToShape{
	
	[AudioController playShape:testShapeIndex delegate:nil];
//	[self startAnimation:sheep];
	[AnimationiManager scale:sheep withScale:1.5 times:1];
	
}

#pragma mark - View
//from NumberView: 0 - 9
- (void)numberClicked:(int)_numberIndex{
    
    // if spiel modus, play sound, to colorView,
	
    NSLog(@"number:%d",_numberIndex);
    selectedNumberIndex = _numberIndex;

	if (selectedNumberIndex == testNumberindex) {
		[self toColor];
	}
	else {

		[AudioController playWrongButton];
		[AudioController playNumber:selectedNumberIndex delegate:nil];
	}
	
}

// from colorview : 0 - 6
- (void)colorClicked:(int)colorIndex{
    
    selectedColorIndex = colorIndex;

    
      // if test modus, if number == indexnumber, to colorview

	if (colorIndex == testColorIndex) {
		[self toShape];
	}
	else {

		[AudioController playWrongButton];
		[AudioController playColor:selectedColorIndex delegate:nil];

	}
    
}

//from shapeview: 0-5

- (void)shapeView:(XCShapeView *)shapeView didClickShape:(Shape)_shape{
	L();
	
	selectedShapeIndex = _shape;
	

        if (selectedShapeIndex == testShapeIndex) {
            [self toResult];
        } else {
			[AudioController playWrongButton];
           [AudioController playShape:selectedShapeIndex delegate:nil];
        }


}

#pragma mark - additional functions


//-(IBAction)goHomeView:(id)sender{
//    //    if (self.view != nil) {
//    NSLog(@"home clicked");
//
//
//    [self toNumber];
//    
//
//    [self.view removeFromSuperview];
//  
//    
//}
//
//-(void)startAnimation:(UIButton*)btn{
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:1.5];
//    
//    btn.transform = CGAffineTransformMakeScale(1.5, 1.5);
//    btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
//    [UIView commitAnimations];
//}

-(IBAction)sheepPressed:(id)sender{

	[AnimationiManager scale:sheep withScale:1.5 times:1];
    
    if (page == SpielPageNumber) {

		[AudioController playNumber:testNumberindex delegate:nil];
    }
    else if (page == SpielPageColor) {

		[AudioController playColor:testColorIndex delegate:nil];
    }
    else if (page == SpielPageShape) {

		[AudioController playShape:testShapeIndex delegate:nil];
    }    
    else {
        NSLog(@"else");
    }
}



@end
