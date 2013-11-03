//
//  PatientalGateValidator.h
//  3in1KidsGames
//
//  Created by AppDevelopper on 13-10-22.
//
//

#import <Foundation/Foundation.h>



//static int sum;

@interface ParentalGateValidator : NSObject<UIAlertViewDelegate>{
    
    int sum;

}



- (id)initWithViewController:(UIViewController*)vc;

- (void)validate;
- (void)execute;

@end

