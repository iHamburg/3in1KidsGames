//
//  PatientalGateValidator.m
//  3in1KidsGames
//
//  Created by AppDevelopper on 13-10-22.
//
//

#import "ParentalGateValidator.h"
#import "LoadingView.h"

@implementation ParentalGateValidator

@synthesize completionHandler;
//
//- (id)initWithViewController:(UIViewController*)vc{
//    if (self = [self init]) {
//        
//    }
//    
//    return self;
//}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"buttonIndex # %d",buttonIndex);
    if (buttonIndex == 1) {
        NSString *text = [[alertView textFieldAtIndex:0] text];
        
        BOOL completed;
        
        if ([text intValue] == sum) {
            NSLog(@"solved");
            completed = YES;

            
        }
        else{
            NSLog(@"wrong answer");
            completed = NO;
        }
        
        completionHandler(completed);
    }
}

- (void)validate{
    int x = arc4random()%100;
    int y = arc4random()%100;
    
    sum = x + y;
    
    NSString *frageText = [NSString stringWithFormat:@"%d + %d",x,y];
    
    UIAlertView *parentalGateAlert = [[UIAlertView alloc] initWithTitle:@"Solve to Enter Parents Section" message:frageText delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
    parentalGateAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [parentalGateAlert show];
    
}

//- (void)execute{
//    
//}
@end
