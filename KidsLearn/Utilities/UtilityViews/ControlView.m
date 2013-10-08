/*
    File: MyView.m
Abstract: MyView several subviews, each of which can be moved by gestures. Illustrates handling gesture events, incluing multiple gestures.
 Version: 1.13

 */

#import <QuartzCore/QuartzCore.h>
#import "ControlView.h"



@implementation ControlView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame{
	if (self = [super initWithFrame:frame]) {

		[self load];
		[self setup];
	
	}
	
	return self;
}

- (void)awakeFromNib{
	[self load];
	[self setup];
	
}


- (void)load{
	
	self.backgroundColor = [UIColor clearColor];
	self.clipsToBounds = YES;	
	
}
- (void)setup{

}
#pragma mark -
#pragma mark === Setting up and tearing down ===
#pragma mark

// adds a set of gesture recognizers to one of our piece subviews
- (void)addGestureRecognizersToPiece:(UIView *)piece
{
	UIRotationGestureRecognizer* rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotatePiece:)];
    
	UIPinchGestureRecognizer* pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scalePiece:)];
    [pinchGesture setDelegate:self];
  	
	
	UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    [tapGesture setNumberOfTapsRequired:2];
    
	UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [tap setNumberOfTapsRequired:1];
    
	UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPiece:)];
    [panGesture setMaximumNumberOfTouches:2];
    [panGesture setDelegate:self];
  	
	UILongPressGestureRecognizer* longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressed:)];
	

	[piece addGestureRecognizer:rotationGesture];
	
	[piece addGestureRecognizer:pinchGesture];
	
	
	[piece addGestureRecognizer:tapGesture];
	
	[piece addGestureRecognizer:tap];
	
	[piece addGestureRecognizer:panGesture];
	
	[piece addGestureRecognizer:longPressGesture];

    
}




#pragma mark -  === Utility methods  ===
// scale and rotation transforms are applied relative to the layer's anchor point
// this method moves a gesture recognizer's view's anchor point between the user's fingers
- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
   
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = gestureRecognizer.view;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
      //  NSLog(@"anchorPoint:%@,center:%@",NSStringFromCGPoint(piece.layer.anchorPoint),NSStringFromCGPoint(piece.center));
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
		
		
    }
}


// ensure that the pinch, pan and rotate gesture recognizers on a particular view can all recognize simultaneously
// prevent other gesture recognizers from recognizing simultaneously
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    
    // if the gesture recognizers's view isn't one of our pieces, don't allow simultaneous recognition
	//    if (gestureRecognizer.view != firstPieceView && gestureRecognizer.view != secondPieceView && gestureRecognizer.view != thirdPieceView)
	//        return NO;
	//    
    // if the gesture recognizers are on different views, don't allow simultaneous recognition
    if (gestureRecognizer.view != otherGestureRecognizer.view)
        return NO;  
    
    // if either of the gesture recognizers is the long press, don't allow simultaneous recognition
	//    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]] || [otherGestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]])
	//        return NO;
    
    return YES;
}


// display a menu with a single item to allow the piece's transform to be reset
//- (void)showResetMenu:(UILongPressGestureRecognizer *)gestureRecognizer
//{
//    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
//        UIMenuController *menuController = [UIMenuController sharedMenuController];
//        UIMenuItem *resetMenuItem = [[UIMenuItem alloc] initWithTitle:@"Reset" action:@selector(resetPiece:)];
//        CGPoint location = [gestureRecognizer locationInView:[gestureRecognizer view]];
//        
//        [self becomeFirstResponder];
//        [menuController setMenuItems:[NSArray arrayWithObject:resetMenuItem]];
//        [menuController setTargetRect:CGRectMake(location.x, location.y, 0, 0) inView:[gestureRecognizer view]];
//        [menuController setMenuVisible:YES animated:YES];
//        
//        selectedPiece = (EditableView*)[gestureRecognizer view];
//        
//    }
//}


// animate back to the default anchor point and transform
- (void)resetPiece:(UIMenuController *)controller
{
    CGPoint locationInSuperview = [selectedPiece convertPoint:CGPointMake(CGRectGetMidX(selectedPiece.bounds), CGRectGetMidY(selectedPiece.bounds)) toView:[selectedPiece superview]];
    
    [[selectedPiece layer] setAnchorPoint:CGPointMake(0.5, 0.5)];
    [selectedPiece setCenter:locationInSuperview];
    
    [UIView beginAnimations:nil context:nil];
    [selectedPiece setTransform:CGAffineTransformIdentity];
    [UIView commitAnimations];
}



// UIMenuController requires that we can become first responder or it won't display
- (BOOL)canBecomeFirstResponder
{
    return YES;
	
}

#pragma mark -
#pragma mark === Touch handling  ===
#pragma mark


// shift the piece's center by the pan amount
// reset the gesture recognizer's translation to {0, 0} after applying so the next callback is a delta from the current position
- (void)panPiece:(UIPanGestureRecognizer *)gestureRecognizer
{

	
	if ([delegate respondsToSelector:@selector(willPanPiece:inView:)]) {
		[delegate willPanPiece:gestureRecognizer inView:self];
	}
   
	
	UIView *piece = [gestureRecognizer view];

	
	[self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
	

    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gestureRecognizer translationInView:[piece superview]];
        
        [piece setCenter:CGPointMake([piece center].x + translation.x, [piece center].y + translation.y)];
        [gestureRecognizer setTranslation:CGPointZero inView:[piece superview]];
    }
     

	// set piece to the front
	[self addSubview:piece];

	
  }

// rotate the piece by the current rotation
// reset the gesture recognizer's rotation to 0 after applying so the next callback is a delta from the current rotation
- (void)rotatePiece:(UIRotationGestureRecognizer *)gestureRecognizer
{


//    if ([delegate respondsToSelector:@selector(willRotatePiece:inView:)]) {
//		[delegate willRotatePiece:gestureRecognizer inView:self];
//	}
	
//	EditableView *piece = (EditableView*)[gestureRecognizer view];
//	if (piece.locked) {
//		return;
//	}
	
	[self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        [gestureRecognizer view].transform = CGAffineTransformRotate([[gestureRecognizer view] transform], [gestureRecognizer rotation]);
        [gestureRecognizer setRotation:0];

    }
    
    
}

// scale the piece by the current scale
// reset the gesture recognizer's rotation to 0 after applying so the next callback is a delta from the current scale
- (void)scalePiece:(UIPinchGestureRecognizer *)gestureRecognizer
{


	
	[self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
		
		
        [gestureRecognizer view].transform = CGAffineTransformScale([[gestureRecognizer view] transform], [gestureRecognizer scale], [gestureRecognizer scale]);
        [gestureRecognizer setScale:1];

    }
}

- (void)handleTap:(UITapGestureRecognizer*)gesture{
	
}

- (void)handleDoubleTap:(UITapGestureRecognizer*)gesture{
    L();
//	EditableView *piece = (EditableView*)[gesture view];
//	if (piece.locked) {
//		return;
//	}
//	
//    EditableView *v = (EditableView*)[gesture view];
//	if ([v isKindOfClass:[PhotoEditableView class]]) {  
//		[delegate controlView:self copyEditView:v];
//	}
	
}
- (void)handleLongPressed:(UILongPressGestureRecognizer *)gestureRecognizer{
	if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
		
//        UIMenuController *menuController = [UIMenuController sharedMenuController];
//		
//		
//        CGPoint location = [gestureRecognizer locationInView:[gestureRecognizer view]];
//        
//        [self becomeFirstResponder];
//		
//		selectedPiece = (EditableView*)[gestureRecognizer view];
//		
//		[menuController setMenuItems:selectedPiece.menuArray];
//        [menuController setTargetRect:CGRectMake(location.x, location.y, 0, 0) inView:[gestureRecognizer view]];
//        [menuController setMenuVisible:YES animated:YES];
        
    }
}

//#pragma mark - Contrainer Gesture
//- (void)handleTapInContrainer:(UITapGestureRecognizer*)gesture{
////	L();
//	UIMenuController *menuController = [UIMenuController sharedMenuController];
//	[menuController setMenuVisible:NO animated:YES];
//}


#pragma mark - Intern
- (void)copyPiece:(UIView*)piece{
//    DLog(@"piece:%@",piece);
	L();
//	int picNum = [delegate picNum];
//	
//	if (picNum<MAXPICKEDPHOTO) {
//		PhotoEditableView* aPiece = (PhotoEditableView*)piece;
//		PhotoEditableView *copy = [aPiece copy];		
//
//		[[NSNotificationCenter defaultCenter] postNotificationName:NotifiAddPicture object:[NSArray arrayWithObject:copy]];
//	}
//	
//	else{
//		[[AutoAlertView sharedAutoAlertView] addInView:self withTitle:NSLocalizedString(@"MaxPictureTitle", nil)];
//
//	}
	
//	PhotoEditableView* aPiece = (PhotoEditableView*)piece;
//	PhotoEditableView *copy = [aPiece copy];		
	
//	[[NSNotificationCenter defaultCenter] postNotificationName:NotifiAddPicture object:[NSArray arrayWithObject:copy]];
	
}



- (void)editTextLabelView:(UIView*)v{

	
//	[[NSNotificationCenter defaultCenter]
//	 postNotificationName:NotifiRootOpenTextLabelVC object:[NSArray arrayWithObject:v]];	

}

#pragma mark - Menu


- (void)menuLockPiece:(UIMenuController *)controller{
	
	if ([delegate respondsToSelector:@selector(handleMenuAction:withPiece:)])
		[delegate handleMenuAction:MA_Lock withPiece:selectedPiece];
}

- (void)menuUnlockPiece:(UIMenuController *)controller{
//	L();
	
//	selectedPiece.locked = NO;
	//	[self switchGestureRecognizersToPiece:selectedPiece toLock:NO];
	if ([delegate respondsToSelector:@selector(handleMenuAction:withPiece:)])
		[delegate handleMenuAction:MA_Unlock withPiece:selectedPiece];

}

- (void)menuSetBackground:(UIMenuController *)controller{
	L();

	if ([delegate respondsToSelector:@selector(handleMenuAction:withPiece:)])
		[delegate handleMenuAction:MA_SetBG withPiece:selectedPiece];

}

- (void)menuEdit:(UIMenuController*)controller{
	L();
	
//	[self editTextLabelView:selectedPiece];
	if ([delegate respondsToSelector:@selector(handleMenuAction:withPiece:)])
		[delegate handleMenuAction:MA_Edit withPiece:selectedPiece];

}

@end
