//
//  MyStoreObserver.h
//  SignatureN
//
//  Created by fanshao on 09-9-1.
//  Copyright 2009 Sensky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h> 
#import "Utilities.h"
#import "LoadingView.h"

#define kIAPFullVersion @"de.xappsoft.kidslearnnscfree.fullversion"

@protocol IAPDelegate;

@interface MyStoreObserver : NSObject< SKPaymentTransactionObserver,SKProductsRequestDelegate>{
	NSMutableArray *purchasedItemIDs;
}

@property (nonatomic, unsafe_unretained) id<IAPDelegate>delegate;

+ (id)sharedInstance;

- (void) completeTransaction: (SKPaymentTransaction *)transaction;
- (void) failedTransaction: (SKPaymentTransaction *)transaction;
- (void) restoreTransaction: (SKPaymentTransaction *)transaction;

//public
- (void) checkRestoredItemsWithDelegate:(id<IAPDelegate>)delegate;
- (void) requestProductWithIdendifier:(NSString*)iden delegate:(id<IAPDelegate>)delegate;

@end

@protocol IAPDelegate <NSObject>

- (void)didCompleteIAPWithIdentifier:(NSString*)identifier;

@end