//
//  TPDPaymentItem.h
//
//  Copyright © 2017 Cherri Tech, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PassKit/PassKit.h>

@interface TPDPaymentItem : NSObject

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSDecimalNumber *amount;

/**
 Initialize PaymentItem

 @param itemName NSString, PaymentItem Name, Shown In The Apple Pay Form.
 @param amount NSDecimalNumber, Amount, , Shown In The Apple Pay Form As '10.00'.
 @return instancetype
 */
+ (instancetype)paymentItemWithItemName:(NSString *)itemName withAmount:(NSDecimalNumber *)amount;

@end
